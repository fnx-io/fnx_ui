import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart';
import 'dart:html';
import 'dart:async';
import 'package:fnx_ui/src/util/async.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';

const CUSTOM_SELECT_VALUE_ACCESSOR = const Provider(  NG_VALUE_ACCESSOR,
                                                      useExisting: FnxSelect,
                                                      multi: true);

@Component(
    selector: 'fnx-select',
    templateUrl: 'fnx_select.html',
    providers: const [CUSTOM_SELECT_VALUE_ACCESSOR]
)
class FnxSelect extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy {

  List<FnxOptionValue> options = [];

  @Input() String selectionEmptyLabel = "Select...";
  @Input() String optionsEmptyLabel = "No options to choose from";
  @Input() String optionsEmptySearchLabel = "No option matches your search";

  bool open = false;
  bool openUp = false;
  @Input() bool neverShowFilter = false;
  @Input() bool alwaysShowFilter = false;

  bool _multi = false;

  var onChange = (_) {};
  var onTouched = (_) {};

  dynamic _value;
  @Output() EventEmitter valueChange = new EventEmitter();

  FnxOptionValue _highlighted;

  String _filter = null;
  List<FnxOptionValue> _cachedFilteredOptions = null;

  @ContentChild(NgFormControl) NgFormControl state;

  StreamSubscription<MouseEvent> globalClicks;
  StreamSubscription<String> navigationActions;

  Node container;

  FnxSelect(ElementRef el, @Optional() FnxInput wrapper): super(wrapper) {
    if (el != null) {
      container = el.nativeElement;
      elementPositionStream(container).listen((double position) {
         openUp = position > 0.5;
      });
    }
  }

  void toggleDropdown() {
    if (open) {
      hideOptions();
    } else {
      showOptions();
    }
  }

  void hideOptions() {
    open = false;
    filter = null;
  }

  void showOptions() {
    open = true;
  }

  get showFilter {
    if (neverShowFilter) return false;
    if (alwaysShowFilter) return true;
    if (options != null && options.length > 10) return true;
  }

  @Input()
  set multi(bool flag) {
    if (flag) {
      if (_value == null) {
        _value = [];
      } else if (!(_value is List)) {
        _value = [_value];
      }
    } else {
      if ((_value is List) && _value.length > 0) {
        _value = _value[0];
      }
    }
    _multi = flag;
  }

  get multi => _multi;

  bool isSelected(dynamic value) {
    if (_value == null) return value == null;
    if (value == null) return false;
    if (_value is List) {
      return _value.contains(value);
    } else {
      return _value == value;
    }
  }

  bool isHighlighted(FnxOptionValue opt) {
    return _highlighted != null && _highlighted == opt;
  }

  /// returns label constructed from all selected option labels joined by ','
  /// in the order they were defined in the options collection
  String renderSelectedOptions () {
    List<FnxOptionValue> allSelected;
    if (_value == null) {
      allSelected = [];
    } else if (_value is List) {
      Set selected = new Set.from(_value as List);
      allSelected = options.where((opt) {
        return selected.contains(opt.value);
      }).toList();
    } else {
      FnxOptionValue found = options.firstWhere((opt) {
        return opt.value == _value;
      }, orElse: () => null);
      if (found != null) {
        allSelected = [found];
      } else {
        allSelected = [];
      }
    }
    if (allSelected.isEmpty) {
      return selectionEmptyLabel;
    } else {
      return allSelected.map((opt) => opt.label).join(', ');
    }
  }

  void selectOption(dynamic value, Event event) {
    event.stopPropagation();
    doSelectOption(value);
  }

  void doSelectOption(dynamic value) {
    if (multi) {
      toggleSelectedOption(value);
    } else {
      if (_value == value) {
        // _value = null; asi ne
      } else {
        _value = value;
      }
      hideOptions();
    }
    valueChange.emit(_value);
    onChange(_value);
    errorStateChange.emit(hasError(state));
  }

  void toggleSelectedOption(dynamic value) {
    if (_value == null) {
      _value = [];
    } else if (!(_value is List)) {
      _value = [_value];
    }
    if (_value.contains(value)) {
      _value.remove(value);
    } else {
      _value.add(value);
    }
  }
  @Input()
  set filter(String value) {
    if (value != null) {
      value = value.toLowerCase();
    }
    _cachedFilteredOptions = null;
    _filter = value;
  }
  get filter => _filter;

  List<FnxOptionValue> get filteredOptions {
    if (_filter != null) {
      if (_cachedFilteredOptions != null ) return _cachedFilteredOptions;
      var result = options.where((option) {
        return option.label.toLowerCase().contains(filter);
      }).toList();
      _cachedFilteredOptions = null;
      return result;
    } else {
      return options;
    }
  }

  StreamSubscription<String> bindKeyHandler(ElementStream<KeyboardEvent> stream) {
    Map<int, String> actions = {KeyCode.ENTER: 'SELECT',
                                KeyCode.ESC: 'HIDE',
                                KeyCode.UP: 'UP',
                                KeyCode.DOWN: 'DOWN'};
    Set<int> supportedKeys = new Set.from(actions.keys);
    Stream<KeyboardEvent> onlyWhenExpanded = stream.where((event) => open && !isActiveElement(event.target));
    Stream<KeyboardEvent> onlySupported = onlyWhenExpanded.where((event) => supportedKeys.contains(event.keyCode));
    Stream<KeyboardEvent> cancelled = onlySupported.map((event) {
      event.preventDefault();
      return event;
    });
    Stream<String> result = cancelled.map((event) => actions[event.keyCode]);

    return result.listen((action) {
      if (action == 'UP') {
        selectNext(_highlighted, filteredOptions.reversed);
      } else if (action  == 'DOWN') {
        selectNext(_highlighted, filteredOptions);
      } else if (action == 'SELECT') {
        if (_highlighted != null) doSelectOption(_highlighted.value);
      } else if (action == 'HIDE') {
        hideOptions();
      }
    });
  }

  void selectNext(FnxOptionValue current, Iterable<FnxOptionValue> options) {
    FnxOptionValue next = findNext(current, options);
    _highlighted = next;
  }

  FnxOptionValue findNext(FnxOptionValue current, Iterable<FnxOptionValue> all) {
    // we have nowhere to navigate
    if (all == null || all.isEmpty) return null;
    // current is empty, return first option
    if (current == null)  return options.first;
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
  ngOnInit() {
    super.ngOnInit();
    var self = this;
    this.globalClicks = document.onClick.listen((event) {
      if (!self.open) return;
      if (isEventFromSubtree(event, container)) return;
      hideOptions();
    });
    this.navigationActions = bindKeyHandler(document.onKeyDown);
  }

  @override
  ngOnDestroy() {
    cancelSubscription(globalClicks);
    globalClicks = null;
    cancelSubscription(navigationActions);
    navigationActions = null;
  }

  bool get error {
    return hasError(state);
  }

  @override
  void registerOnChange(fn) {
    onChange = fn;
  }

  @override
  void registerOnTouched(fn) {
    onTouched = fn;
  }

  @override
  void writeValue(obj) {
    _value = obj;
    onChange(obj);
  }
}

class FnxOptionValue {
  final String id = uid('ov_');
  final String label;
  final String value;

  FnxOptionValue(this.value, this.label);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is FnxOptionValue &&
        this.value == other.value;
  }

  @override
  int get hashCode {
    return value.hashCode;
  }

  @override
  String toString() {
    return 'FnxOptionValue{id: $id, value: $value, label: $label}';
  }
}

@Component(
    selector: 'fnx-option',
    templateUrl: 'fnx_option.html'
)
class FnxOption implements OnInit {

  FnxSelect parent;

  @Input()
  dynamic value;

  @Input()
  String label;

  FnxOption(this.parent);

  @override
  ngOnInit() {
    parent.options.add(new FnxOptionValue(value, label));
  }
}

const FNX_SELECT_DIRECTIVES = const [FnxSelect, FnxOption];
