import 'dart:html';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/validator.dart';

const CUSTOM_INPUT_TEXT_VALUE_ACCESSOR = const Provider(ngValueAccessor, useExisting: FnxText);

///
/// Text input. Possible types are:
/// - text
/// - number
/// - email
/// - http (https or http URI)
///
@Component(
  selector: 'fnx-text',
  template: r'''
<input id="{{ componentId }}" type="{{ htmlType }}" [(ngModel)]="value" [readonly]="isReadonly"  [disabled]="isDisabled"
  [attr.minlength]="minLength?.toString()"
  [attr.maxlength]="maxLength?.toString()"
  [attr.min]="min?.toString()"
  [attr.max]="max?.toString()"
  [attr.autocomplete]="autocomplete"
  (keyup)="markAsTouched()"
  [class.error]="isTouchedAndInvalid()"
  [attr.step]="decimalsAttr"
  [attr.placeholder]="placeholder"
  [attr.tabindex]="(isReadonly || isDisabled) ? '-1' : '0'"
  #input
/>
''',
  providers: const [
    CUSTOM_INPUT_TEXT_VALUE_ACCESSOR,
    const Provider(Focusable, useExisting: FnxText),
    const Provider(FnxValidatorComponent, useExisting: FnxText),
  ],
  styles: const [":host input { text-align: inherit;}"],
  preserveWhitespace: false,
  directives: [coreDirectives, formDirectives],
)
class FnxText extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy, Focusable {
  @Input()
  bool required = false;

  @Input()
  int? minLength = null;

  @Input()
  int? maxLength = null;

  @Input()
  int? min = null;

  @Input()
  int? max = null;

  @Input()
  String type = 'text';

  @Input()
  String? placeholder = null;

  @Input()
  String autocomplete = "off";

  @Input()
  bool readonly = false;

  @Input()
  bool disabled = false;

  @ViewChild("input")
  HtmlElement? element;

  int _decimals = 0;

  FnxText(@SkipSelf() @Optional() FnxValidatorComponent? parent) : super(parent);

  String get htmlType {
    switch (type) {
      case 'password':
      case 'number':
        return type;
      case 'decimal':
        return 'number';
      default:
        return 'text';
    }
  }

  static final RegExp _EMAIL_REGEXP =
      new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  @override
  ngOnInit() {
    super.ngOnInit();
    assertType();
  }

  int? get decimals {
    if (type == 'decimal') return _decimals;

    return null;
  }

  String? get decimalsAttr {
    int? dec = decimals;
    if (dec == null) return null;
    if (dec == 0) return '1';

    return '0.' + '1'.padLeft(dec, '0');
  }

  @Input()
  set decimals(int? decimals) {
    if (decimals == null || decimals < 0 || decimals > 12) {
      throw "Invalid decimals count for decimal field. Min 0 max 12 decimals.";
    }
    _decimals = decimals;
  }

  @override
  bool hasValidValue() {
    assertType();

    if (required && value == null) return false;
    if (value == null) return true;

    if (type == "text" || type == "http" || type == "email" || type == "password") {
      return hasValidTextImpl();
    } else if (type == "number") {
      return hasValidNumberImpl();
    } else if (type == "decimal") {
      return hasValidNumberImpl() && hasValidDecimals();
    } else {
      throw "This really should not happen: type=${type}";
    }
  }

  ///
  /// Is this a valid number within min/max limits?
  ///
  bool hasValidNumberImpl() {
    if (min == null && max == null) return true;
    num? v = parseNum(value);

    if (v == null && value != null && value.toString().length > 0) return false; // not a number
    if (required && v == null) return false;
    if (min != null && v! < min!) return false;
    if (max != null && v! > max!) return false;
    return true;
  }

  bool hasValidDecimals() {
    num? v = parseNum(value);
    if (v == null) return true;

    if (decimals! < 1) {
      return v.toInt() == v;
    } else {
      int fac = pow(10, decimals!) as int;
      int i = (v.abs() * fac).toInt();
      double d = (v.abs() * fac).toDouble();

      double diff = d - i;
      double threshold = 1e-7;

      return diff.abs() < threshold;
    }
  }

  num? parseNum(value) {
    return (value is num) ? value : num.tryParse(value);
  }

  ///
  /// Is this valid text within maxLength and minLength limits?
  /// Is it valdi email or http URI?
  ///
  bool hasValidTextImpl() {
    if (minLength == null && maxLength == null && type == "text") return true;
    String? v = (value is String) ? value : value.toString();

    if (required && v!.length == 0) return false;
    if (minLength != null && v!.length < minLength!) return false;
    if (maxLength != null && v!.length > maxLength!) return false;

    if (type == "http") {
      // TODO: this parsing might be expensive, we should cache results
      try {
        Uri u = Uri.parse(v!);
        String scheme = u.scheme.toLowerCase();
        if (scheme != "http" && scheme != "https") return false;

        if ((u.host == null || u.host.isEmpty) && (u.path == null || u.path.isEmpty)) return false;
        return true;
      } catch (e) {
        return false;
      }
    }

    if (type == "email") {
      return _EMAIL_REGEXP.hasMatch(v!);
    }
    return true;
  }

  void assertType() {
    if (type != "text" && type != "number" && type != "email" && type != "http" && type != "password" && type != "decimal") {
      throw "The only possible types at this moment are 'text', 'number', 'decimal', 'email', 'http' and 'password'";
    }
  }

  @override
  void focus() {
    if (element != null) {
      element!.focus();
    }
  }
}
