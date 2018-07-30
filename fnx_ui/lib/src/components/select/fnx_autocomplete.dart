import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/util/async.dart';
import 'package:fnx_ui/src/util/pair.dart';
import 'package:fnx_ui/src/util/ui.dart';
import 'package:fnx_ui/src/validator.dart';

typedef Future<List<Pair>> OptionsProvider(String filledText);
typedef Future<Pair> DefaultOptionProvider(var initialValue);

const CUSTOM_AUTOCOMPLETE_VALUE_ACCESSOR = const Provider(ngValueAccessor, useExisting: FnxAutocomplete, multi: true);

@Component(
  selector: 'fnx-autocomplete',
  templateUrl: 'fnx_autocomplete.html',
  providers: const [
    CUSTOM_AUTOCOMPLETE_VALUE_ACCESSOR,
    const Provider(Focusable, useExisting: FnxAutocomplete, multi: false),
    const Provider(FnxValidatorComponent, useExisting: FnxAutocomplete, multi: false),
  ],
  preserveWhitespace: false,
  directives: [
    coreDirectives,
    formDirectives,
    AutoFocus
  ],
)
class FnxAutocomplete extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy, Focusable {

  @Input()
  bool required = false;

  @Input()
  bool readonly = false;

  @Input()
  bool disabled = false;

  @Input()
  bool nullable = false;

  @Input()
  String placeholder = null;

  String nothingFoundLabel = "Nenašel jsem nic";

  @Input()
  OptionsProvider optionsProvider;

  @Input()
  DefaultOptionProvider defaultOptionProvider;

  String _text;

  bool open = false;

  bool get dropDownVisible => open && !isReadonly && options.isNotEmpty;

  DropdownTracker dropdownTracker = new DropdownTracker(downOnly: true);

  StreamSubscription<String> navigationActions;
  StreamSubscription<String> filledTextChangedSubscription;
  StreamController<String> filledTextChanged = new StreamController();

  List<Pair> options = [];

  List<Pair> loadedOptions = [];

  @ViewChild("dropdown")
  HtmlElement dropdown;

  @ViewChild("select")
  HtmlElement select;

  @ViewChild("input")
  HtmlElement input;

  String get text => _text;

  @Input()
  set text(String val) {
    _text = val;
    filledTextChanged.add(val);
    if (_text != null) {
      showOptions();
    }
  }

  FnxModal modal;

  FnxAutocomplete(@Optional() this.modal, @SkipSelf() @Optional() FnxValidatorComponent parent)
      : super(parent) {
    filledTextChangedSubscription = filledTextChanged.stream
        .transform(new FnxStreamDebouncer(new Duration(milliseconds: 50)))
        .listen(loadFreshOptions);
  }

  void writeValue(obj) {
    // pricestovala nova hodnota z modelu
    super.writeValue(obj);
    _text = null;
    if (value == null) return;
    if (loadedOptions != null || loadedOptions.isNotEmpty) {
      Pair p = loadedOptions.firstWhere((Pair p) => p.value == obj, orElse: () => null);
      if (p != null) {
        _text = p.label;
      }
    }
    if (_text == null) {
      loadInitialOption();
    }
  }

  void hideOptions() {
    modal?.activeChilds?.remove(this);
    open = false;
    if (value != null) {
      _text = options.firstWhere((Pair p) => p.value == value, orElse: () => null)?.label;
    }
  }

  void showOptions() {
    modal?.activeChilds?.add(this);
    open = true;
    dropdownTracker.updatePosition();
    later(dropdownTracker.updatePosition);
  }

  bool isSelected(dynamic v) {
    return value == v;
  }

  bool isHighlighted(Pair opt) {
    return _highlighted == opt;
  }

  void selectOption(Pair pair) {
    value = pair.value;
    _text = pair.label;
    hideOptions();
  }

  Pair _highlighted = null;

  StreamSubscription<String> bindKeyHandler(Stream<KeyboardEvent> stream) {
    Map<int, String> actions = {KeyCode.ENTER: 'SELECT', KeyCode.ESC: 'HIDE', KeyCode.UP: 'UP', KeyCode.DOWN: 'DOWN'};
    Set<int> supportedKeys = new Set.from(actions.keys);
    Stream<KeyboardEvent> onlyWhenExpanded = stream.where((event) => isEventFromSubtree(event, select));
    Stream<KeyboardEvent> onlySupported = onlyWhenExpanded.where((event) => supportedKeys.contains(event.keyCode));
    Stream<KeyboardEvent> cancelled = onlySupported.map((event) {
      event.preventDefault();
      return event;
    });
    Stream<String> result = cancelled.map((event) => actions[event.keyCode]);

    return result.listen((action) {
      if (action == 'UP') {
        if (dropDownVisible) {
          highlightNext(_highlighted, options.reversed);
          scrollToHighlighted();
        }
      } else if (action == 'DOWN') {
        if (!dropDownVisible) {
          showOptions();
        } else {
          highlightNext(_highlighted, options);
          scrollToHighlighted();
        }
      } else if (action == 'SELECT') {
        if (!dropDownVisible) {
          showOptions();
        } else {
          if (_highlighted != null) selectOption(_highlighted);
        }
      } else if (action == 'HIDE') {
        hideOptions();
      }
    });
  }

  void highlightNext(Pair current, Iterable<Pair> options) {
    Pair next = findNext(current, options);
    _highlighted = next;
  }

  Pair findNext(Pair current, Iterable<Pair> all) {
    // we have nowhere to navigate
    if (all == null || all.isEmpty) return null;
    // current is empty, return first option
    if (current == null && options.isEmpty) return null;
    if (current == null) return options.first;
    // drop all items until we find current in the collection of all
    var currentAndRest = all.skipWhile((option) => option != current);
    // current has not been found in the collection of all options, return first
    if (currentAndRest.isEmpty) return all.first;
    // skip current and get rest of the options
    var rest = currentAndRest.skip(1);
    // if current has been the last, return first option
    if (rest.isEmpty) return all.first;
    // else return the next item
    return rest.first;
  }

  @override
  ngOnInit() async {
    super.ngOnInit();
    this.navigationActions = bindKeyHandler(document.onKeyDown);
    dropdownTracker.init(select, dropdown, hideOptions);
  }

  @override
  ngOnDestroy() {
    super.ngOnDestroy();
    navigationActions?.cancel();
    filledTextChangedSubscription?.cancel();
    navigationActions = null;
    dropdownTracker.destroy();
  }

  @override
  bool hasValidValue() {
    if (required) {
      if (value == null) return false;
    }
    return true;
  }

  int version = 0;

  Future<Null> loadInitialOption() async {
    if (defaultOptionProvider == null) return;
    version++;
    int loadingFor = version;
    Pair loaded = await defaultOptionProvider(value);
    if (loadingFor == version) {
      // we will use this
      if (loaded != null) {
        _text = loaded.label;
        loadedOptions = [loaded];
        updateOptionsFromSearch();
      }
    } else {
      // too old next batch is comming
    }
  }

  Future<Null> loadFreshOptions(String data) async {
    version++;
    int loadingFor = version;
    List<Pair> loaded = await optionsProvider(data);
    if (loadingFor == version) {
      // we will use this
      loadedOptions = loaded ?? const [];
      updateOptionsFromSearch();
    } else {
      // too old next batch is comming
    }
  }

  void updateOptionsFromSearch() {
    options = null;
    if (loadedOptions == null || loadedOptions.isEmpty) {
      options = const [];
      value = null;
      return;
    }
/*
    options = loadedOptions.where((Pair p) {
      return p.label.contains(filledText) || p.value.contains(filledText);
    }).toList();
*/
    options = loadedOptions;
    if (options.isEmpty) {
      value = null;
      return;
    }
    if (options.length == 1) {
      value = options.first.value;
    }

    if (value != null) {
      if (options.firstWhere((Pair p) => p.value == value, orElse: () => null) == null) {
        value = null;
      }
    }
    if (value == null) {
      Pair p = options.firstWhere((Pair p) => p.label == _text, orElse: () => null);
      if (p != null) {
        value = p.value;
      }
    }
  }

  @override
  void focus() {
    later(() {
      if (input != null && input != null) {
        input.focus();
      }
    });
  }

  void scrollToHighlighted() {
    new Future.delayed(new Duration(milliseconds: 100)).then((_) {
      Element e = select.querySelector(".select__dropdown--selected");
      if (e != null) {
        e.scrollIntoView();
      }
    });
  }
}
