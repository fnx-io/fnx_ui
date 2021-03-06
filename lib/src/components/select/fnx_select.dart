import 'dart:async';
import 'dart:html';

import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/util/async.dart';
import 'package:fnx_ui/src/util/global_messages.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:fnx_ui/src/validator.dart';

typedef String ValueDescriptionRenderer();

const CUSTOM_SELECT_VALUE_ACCESSOR = const Provider(NG_VALUE_ACCESSOR, useExisting: FnxSelect, multi: true);

@Component(
  selector: 'fnx-select',
  templateUrl: 'fnx_select.html',
  providers: const [
    CUSTOM_SELECT_VALUE_ACCESSOR,
    const Provider(Focusable, useExisting: FnxSelect, multi: false),
    const Provider(FnxValidatorComponent, useExisting: FnxSelect, multi: false),
  ],
  preserveWhitespace: false,
  directives: const [AutoFocus],
)
class FnxSelect extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy, Focusable {
  @Input()
  bool required = false;
  @Input()
  bool neverShowFilter = false;
  @Input()
  bool alwaysShowFilter = false;
  @Input()
  bool readonly = false;
  @Input()
  bool nullable = false;
  @Input()
  ValueDescriptionRenderer valueDescriptionRenderer;

  List<FnxOptionValue> options = [];

  @Input()
  String selectionEmptyLabel = GlobalMessages.selectSelectionEmptyLabel(); // "Select...";
  @Input()
  String optionsEmptyLabel = GlobalMessages.selectOptionsEmptyLabel(); //"No options to choose from";
  @Input()
  String optionsEmptySearchLabel = GlobalMessages.selectOptionsEmptySearchLabel(); //"No option matches your search";
  @Input()
  String filterPlaceholder = GlobalMessages.selectFilterPlaceholder(); //"Search...";

  bool open = false;
  bool openUp = false;

  bool get dropDownVisible => open && !isReadonly;

  ui.DropdownTracker dropdownTracker = new ui.DropdownTracker();

  bool _multi = false;

  FnxOptionValue _highlighted;

  String _filter = null;
  List<FnxOptionValue> _cachedFilteredOptions = null;

  @ContentChild(NgFormControl)
  NgFormControl state;

  StreamSubscription<MouseEvent> globalClicks;
  StreamSubscription<String> navigationActions;

  Node container;

  @ViewChild("dropdown")
  ElementRef dropdown;

  @ViewChild("select")
  ElementRef select;

  FnxModal modal;

  FnxSelect(ElementRef el, @Optional() this.modal, @SkipSelf() @Optional() FnxValidatorComponent parent)
      : super(parent) {
    if (el != null) {
      container = el.nativeElement;
    }
  }

  void toggleDropdown() {
    markAsTouched();
    if (open) {
      if (!multi) {
        hideOptions();
      }
    } else {
      showOptions();
    }
  }

  void hideOptions() {
    modal?.activeChilds?.remove(this);
    open = false;
    filter = null;
  }

  void showOptions() {
    modal?.activeChilds?.add(this);
    open = true;
    dropdownTracker.updatePosition();
    later(dropdownTracker.updatePosition);
  }

  bool get showFilter {
    if (neverShowFilter) return false;
    if (alwaysShowFilter) return true;
    if (options != null && options.length > 10) return true;
    return false;
  }

  @Input()
  set multi(bool flag) {
    if (flag) {
      if (value == null) {
        value = [];
      } else if (!(value is List)) {
        value = [value];
      }
    } else {
      if ((value is List) && value.length > 0) {
        value = value[0];
      }
    }
    _multi = flag;
  }

  get multi => _multi;

  bool isSelected(dynamic v) {
    if (value == null) return v == null;
    if (v == null) return false;
    if (value is List) {
      return value.contains(v);
    } else {
      return value == v;
    }
  }

  bool isHighlighted(FnxOptionValue opt) {
    return _highlighted == opt;
  }

  /// returns label constructed from all selected option labels joined by ','
  /// in the order they were defined in the options collection
  ///
  /// Pluggable using valueDescriptionRenderer attribute.
  ///
  /// See [ValueDescriptionRenderer].
  ///
  String renderValueDescription() {
    if (valueDescriptionRenderer == null) {
      return _renderValueDescription();
    } else {
      return valueDescriptionRenderer();
    }
  }

  String _renderValueDescription() {
    List<FnxOptionValue> allSelected;
    if (value == null) {
      allSelected = [];
    } else if (value is List) {
      Set selected = new Set.from(value as List);
      allSelected = options.where((opt) {
        return selected.contains(opt.value);
      }).toList();
    } else {
      FnxOptionValue found = options.firstWhere((opt) {
        return opt.value == value;
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

  void selectOption(dynamic value) {
    doSelectOption(value);
  }

  void doSelectOption(dynamic value) {
    if (multi) {
      toggleSelectedOption(value);
    } else {
      if (this.value == value) {
        if (nullable) this.value = null;
      } else {
        this.value = value;
      }
      hideOptions();
    }
  }

  void toggleSelectedOption(dynamic v) {
    if (value == null) {
      value = [];
    } else if (!(value is List)) {
      value = [value];
    }
    if (value.contains(v)) {
      value.remove(v);
      notifyNgModel();
    } else {
      value.add(v);
      notifyNgModel();
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
      if (_cachedFilteredOptions != null) return _cachedFilteredOptions;
      var result = options.where((option) {
        return option.label != null && option.label.toLowerCase().contains(filter);
      }).toList();
      _cachedFilteredOptions = result;
      return result;
    } else {
      return options;
    }
  }

  StreamSubscription<String> bindKeyHandler(Stream<KeyboardEvent> stream) {
    Map<int, String> actions = {KeyCode.ENTER: 'SELECT', KeyCode.ESC: 'HIDE', KeyCode.UP: 'UP', KeyCode.DOWN: 'DOWN'};
    Set<int> supportedKeys = new Set.from(actions.keys);
    Stream<KeyboardEvent> onlyWhenExpanded =
        stream.where((event) => ui.isEventFromSubtree(event, select.nativeElement));
    Stream<KeyboardEvent> onlySupported = onlyWhenExpanded.where((event) => supportedKeys.contains(event.keyCode));
    Stream<KeyboardEvent> cancelled = onlySupported.map((event) {
      event.preventDefault();
      return event;
    });
    Stream<String> result = cancelled.map((event) => actions[event.keyCode]);

    return result.listen((action) {
      if (action == 'UP') {
        if (dropDownVisible) {
          selectNext(_highlighted, filteredOptions.reversed);
        }
      } else if (action == 'DOWN') {
        if (!dropDownVisible) {
          showOptions();
        } else {
          selectNext(_highlighted, filteredOptions);
        }
      } else if (action == 'SELECT') {
        if (!dropDownVisible) {
          showOptions();
        } else {
          if (_highlighted != null) doSelectOption(_highlighted.value);
        }
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
  ngOnInit() {
    super.ngOnInit();
    var self = this;
    this.globalClicks = document.onClick.listen((event) {
      if (!self.open) return;
      if (ui.isEventFromSubtree(event, container)) return;
      hideOptions();
    });
    this.navigationActions = bindKeyHandler(document.onKeyDown);
    dropdownTracker.init(container, dropdown.nativeElement, hideOptions);
  }

  @override
  ngOnDestroy() {
    super.ngOnDestroy();
    cancelSubscription(globalClicks);
    globalClicks = null;
    cancelSubscription(navigationActions);
    navigationActions = null;
    dropdownTracker.destroy();
  }

  @override
  bool hasValidValue() {
    if (required) {
      if (value == null) return false;
      if (multi && value is List && value.isEmpty) return false;
    }
    return true;
  }

  @override
  void focus() {
    select.nativeElement.focus();
  }

  @override
  bool get disabled => false;
}

class FnxOptionValue {
  final String id;
  String label;
  dynamic value;

  FnxOptionValue(this.id, this.value, this.label);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is FnxOptionValue && this.value == other.value;
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
  templateUrl: 'fnx_option.html',
  preserveWhitespace: false,
)
class FnxOption implements OnInit, OnDestroy, OnChanges {
  final String id = ui.uid('ov_');

  FnxSelect parent;

  @Input()
  dynamic value;

  @Input()
  String label;

  FnxOption(this.parent);

  bool _visibilityCache = null;
  int _cacheHashCode = null;

  bool get highlighted => parent.isHighlighted(_myValue);

  bool get visible {
    List<FnxOptionValue> opts = parent?.filteredOptions;
    if (opts == null) return false;
    if (opts.isEmpty) return false;
    if (parent.options.length == opts.length) return true;
    if (opts.hashCode == _cacheHashCode && _visibilityCache != null) return _visibilityCache;
    _cacheHashCode = opts.hashCode;
    _visibilityCache = opts.contains(_myValue);
    return _visibilityCache;
  }

  FnxOptionValue _myValue;

  @override
  ngOnInit() {
    _myValue = new FnxOptionValue(id, value, label);
    parent.options.add(_myValue);
  }

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
    if (_myValue != null) {
      _myValue.value = value;
      _myValue.label = label;
    }
  }

  @override
  ngOnDestroy() {
    parent.options.remove(_myValue);
  }

  void optionSelected(Event event) {
    event?.preventDefault();
    event?.stopPropagation();
    parent?.selectOption(value);
  }

  get selected => parent != null && parent.isSelected(value);
}

const FNX_SELECT_DIRECTIVES = const [FnxSelect, FnxOption];
