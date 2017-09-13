import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/validator.dart';
import 'package:intl/intl.dart';

const CUSTOM_INPUT_FDOUBLE_VALUE_ACCESSOR =
    const Provider(NG_VALUE_ACCESSOR, useExisting: FnxFormattedDouble, multi: true);

@Component(
  selector: 'fnx-formatted-double',
  template: r'''
<input id="{{ componentId }}" type="{{ htmlType }}"
  [(ngModel)]="valueStr"
  [readonly]="isReadonly"
  [attr.autocomplete]="autocompleteAttr"
  (keyup)="markAsTouched()"
  [class.error]="isTouchedAndInvalid()"
  [attr.placeholder]="placeholder"
  (focus)="onFocus()"
  (blur)="onBlur()"
  #input
/>
''',
  providers: const [
    CUSTOM_INPUT_FDOUBLE_VALUE_ACCESSOR,
    const Provider(Focusable, useExisting: FnxFormattedDouble, multi: false),
    const Provider(FnxValidatorComponent, useClass: FnxFormattedDouble, multi: false),
  ],
  styles: const [":host input { text-align: inherit;}"],
  preserveWhitespace: false,
)
class FnxFormattedDouble extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy, Focusable {
  @Input()
  bool required = false;

  // 'text' must not be a constant in the html template !
  String get htmlType => 'text';

  @Input()
  num min = null;

  @Input()
  num max = null;

  @Input()
  String format = "#,##0.00";

  @Input()
  String placeholder = null;

  @Input()
  bool autocomplete = true;

  @Input()
  bool readonly = false;

  String _valueStr;

  @ViewChild("input")
  ElementRef elementRef;

  bool focused = false;

  FnxFormattedDouble(@SkipSelf() @Optional() FnxValidatorComponent parent) : super(parent);

  String get autocompleteAttr => (autocomplete) ? 'on' : 'off';

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
    if (required && value == null) return false;
    if (min == null && max == null) return true;
    double v = parseDouble(value);
    if (v == null) return true;

    if (v == null && value != null && value.toString().length > 0) return false; // not a number
    if (required && v == null) return false;
    if (min != null && v < min.toDouble()) return false;
    if (max != null && v > max.toDouble()) return false;
    return true;
  }

  double parseDouble(value) {
    if (value == null) return null;
    if (value is num) {
      return value.toDouble();
    } else {
      return double.parse(value.toString().replaceAll(",", "."), (_) => null);
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
    if (v == null) {
      super.value = null;
    } else {
      double parsed = parseDouble(v);
      super.value = parsed;
    }
  }

  @override
  void writeValue(obj) {
    value = obj;
    if (!focused) {
      if (value == null) {
        _valueStr = "";
      } else {
        NumberFormat nf = new NumberFormat(format);
        _valueStr = nf.format(value);
      }
    }
  }

  @override
  get value {
    return super.value;
  }

  String get valueStr => _valueStr;

  set valueStr(String v) {
    _valueStr = v;
    value = valueStr;
  }

  void onFocus() {
    focused = true;
    if (value == null) {
      _valueStr = "";
    } else {
      _valueStr = value.toString();
    }
  }

  void onBlur() {
    focused = false;
    if (value == null) {
      _valueStr = "";
    } else {
      NumberFormat nf = new NumberFormat(format);
      _valueStr = nf.format(value);
      value = parseDouble(nf.parse(_valueStr));
    }
  }
}
