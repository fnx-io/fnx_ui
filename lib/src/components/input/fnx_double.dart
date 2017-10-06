import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/validator.dart';

const CUSTOM_INPUT_DOUBLE_VALUE_ACCESSOR = const Provider(NG_VALUE_ACCESSOR, useExisting: FnxDouble, multi: true);

@Component(
    selector: 'fnx-double',
    template: r'''
<input id="{{ componentId }}" type="{{ htmlType }}" [(ngModel)]="value" [readonly]="isReadonly"
  [attr.min]="min"
  [attr.max]="max"
  [attr.step]="step"
  [attr.autocomplete]="autocompleteAttr"
  (keyup)="markAsTouched()"
  [class.error]="isTouchedAndInvalid()"
  [attr.placeholder]="placeholder"
  [attr.tabindex]="(readonly || disabled) ? -1 : 0"  
  #input
/>
''',
    providers: const [
      CUSTOM_INPUT_DOUBLE_VALUE_ACCESSOR,
      const Provider(Focusable, useExisting: FnxDouble, multi: false),
      const Provider(FnxValidatorComponent, useExisting: FnxDouble, multi: false),
    ],
    styles: const [":host input { text-align: inherit;}"],
    preserveWhitespace: false,
)
class FnxDouble extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy, Focusable {

  @Input()
  bool required = false;

  @Input()
  num min = null;

  @Input()
  num max = null;

  @Input()
  num step = 0.1;

  @Input()
  String placeholder = null;

  @Input()
  bool autocomplete = true;

  @Input()
  bool readonly = false;

  @ViewChild("input")
  ElementRef elementRef;

  FnxDouble(@SkipSelf() @Optional() FnxValidatorComponent parent) : super(parent);

  String get autocompleteAttr => (autocomplete) ? 'on' : 'off';

  // 'number' must not be a constant in the html template !
  String get htmlType => 'number';

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
    if (v.isNaN) return false;
    if (v == null && value != null && value.toString().length > 0) return false; // not a number
    if (required && v == null) return false;
    if (min != null && v < min.toDouble()) return false;
    if (max != null && v > max.toDouble()) return false;
    return true;
  }

  double parseDouble(value) {
    if (value == null) return null;
    if (value is num) {
      return value;
    } else {
      return double.parse(value, (_) => double.NAN);
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
  get value {
    return super.value;
  }

  @override
  bool get disabled => false;
}
