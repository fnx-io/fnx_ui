import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';

const CUSTOM_INPUT_INT_VALUE_ACCESSOR = const Provider(NG_VALUE_ACCESSOR, useExisting: FnxInt, multi: true);

@Component(
    selector: 'fnx-int',
    template: r'''
<input id="{{ componentId }}" type="{{ htmlType }}" [(ngModel)]="value" [readonly]="readonly"
  [attr.min]="min"
  [attr.max]="max"
  [attr.autocomplete]="autocompleteAttr"
  (keyup)="markAsTouched()"
  [class.error]="isTouchedAndInvalid()"
  [attr.placeholder]="placeholder"
  #input
/>
''',
    providers: const [
      CUSTOM_INPUT_INT_VALUE_ACCESSOR,
      const Provider(Focusable, useExisting: FnxInt, multi: false)
    ],
    styles: const [":host input { text-align: inherit;}"],
    preserveWhitespace: false
)
class FnxInt extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy, Focusable {

  @Input()
  bool required = false;

  @Input()
  int min = null;

  @Input()
  int max = null;

  @Input()
  String placeholder = null;

  @Input()
  bool autocomplete = true;

  @Input()
  bool readonly = false;

  @ViewChild("input")
  ElementRef elementRef;

  FnxInt(@Optional() FnxForm form, @Optional() FnxInput wrapper) : super(form, wrapper);

  // 'number' must not be a constant in the html template !
  String get htmlType => 'number';

  String get autocompleteAttr => (autocomplete) ? 'on' : 'off';

  var rawValue;

  @override
  ngOnInit() {
    super.ngOnInit();
  }

  @override
  bool hasValidValue() => hasValidNumberImpl();

  ///
  /// Is this a valid number within min/max limits?
  ///
  bool hasValidNumberImpl() {
    if (rawValue != null && rawValue is String) {
      if (value.toString() != rawValue) return false;
    }

    if (min == null && max == null) return true;
    int v = parseNum(value);

    if (v == null && value != null && value.toString().length > 0) return false; // not a number
    if (required && v == null) return false;
    if (min != null && v < min) return false;
    if (max != null && v > max) return false;
    return true;
  }

  num parseNum(value) {
    if (value is num) {
      return value;
    } else {
      return num.parse(value, (_) => null);
    }
  }

  @override
  void focus() {
    if (elementRef != null && elementRef.nativeElement != null) {
      elementRef.nativeElement.focus();
    }
  }

  @override
  set value(dynamic v) {
    rawValue = v;

    if (v == null) {
      super.value = null;
    } else {
      num parsed = parseNum(v);
      super.value = parsed.toInt();
    }
  }

  @override
  get value {
    return super.value;
  }

}
