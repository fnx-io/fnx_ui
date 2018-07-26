import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/validator.dart';

const CUSTOM_INPUT_INT_VALUE_ACCESSOR = const Provider(ngValueAccessor, useExisting: FnxInt, multi: true);

@Component(
  selector: 'fnx-int',
  template: r'''
<input id="{{ componentId }}" type="{{ htmlType }}" [(ngModel)]="value" [readonly]="isReadonly"
  [attr.min]="min"
  [attr.max]="max"
  [attr.autocomplete]="autocompleteAttr"
  (keyup)="markAsTouched()"
  [class.error]="isTouchedAndInvalid()"
  [attr.placeholder]="placeholder"
   [attr.tabindex]="(isReadonly || isDisabled) ? -1 : 0"  
  #input
/>
''',
  providers: const [
    CUSTOM_INPUT_INT_VALUE_ACCESSOR,
    const Provider(Focusable, useExisting: FnxInt, multi: false),
    const Provider(FnxValidatorComponent, useExisting: FnxInt, multi: false),
  ],
  styles: const [":host input { text-align: inherit;}"],
  preserveWhitespace: false,
)
class FnxInt extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy, Focusable {
  @Input()
  bool required = false;

  @Input()
  num min = null;

  @Input()
  num max = null;

  @Input()
  String placeholder = null;

  @Input()
  bool autocomplete = true;

  @Input()
  bool readonly = false;

  @Input()
  bool disabled = false;

  @ViewChild("input")
  HtmlElement element;

  FnxInt(@SkipSelf() @Optional() FnxValidatorComponent parent) : super(parent);

  // 'number' must not be a constant in the html template !
  String get htmlType => 'number';

  String get autocompleteAttr => (autocomplete) ? 'on' : 'off';

  var rawValue;

  @override
  bool hasValidValue() => hasValidNumberImpl();

  ///
  /// Is this a valid number within min/max limits?
  ///
  bool hasValidNumberImpl() {
    if (required && value == null) return false;
    if (rawValue != null && rawValue is String) {
      if (value.toString() != rawValue) return false;
    }

    if (min == null && max == null) return true;
    int v = parseInt(value);
    if (v == null) return true;

    if (v == null && value != null && value.toString().length > 0) return false; // not a number
    if (required && v == null) return false;
    if (min != null && v < min.toInt()) return false;
    if (max != null && v > max.toInt()) return false;
    return true;
  }

  int parseInt(value) {
    if (value == null) return null;
    if (value is int) {
      return value;
    } else {
      return int.parse(value, onError: (_) => null);
    }
  }

  @override
  void focus() {
    if (element != null) {
      element.focus();
    }
  }

  @override
  set value(dynamic v) {
    rawValue = v;

    if (v == null) {
      super.value = null;
    } else {
      int parsed = parseInt(v);
      if (parsed != null) {
        super.value = parsed;
      }
    }
  }

  @override
  get value {
    return super.value;
  }

}
