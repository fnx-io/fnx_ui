import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:angular2/src/common/forms/directives/validators.dart';
import 'package:fnx_ui/src/validator.dart';

const CUSTOM_INPUT_TEXT_VALUE_ACCESSOR = const Provider(NG_VALUE_ACCESSOR, useExisting: FnxText, multi: true);

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
<input id="{{ componentId }}" type="{{ htmlType }}" [(ngModel)]="value" [readonly]="readonly"
  [attr.minlength]="minLength"
  [attr.maxlength]="maxLength"
  [attr.min]="min"
  [attr.max]="max"
  (focus)="markAsTouched()"
  (click)="markAsTouched()"
  [class.error]="isTouchedAndInvalid()"
/>
''',
    providers: const [CUSTOM_INPUT_TEXT_VALUE_ACCESSOR])
class FnxText extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy {

  @Input()
  bool required = false;

  @Input()
  int minLength = null;

  @Input()
  int maxLength = null;

  @Input()
  int min = null;

  @Input()
  int max = null;

  @Input()
  String type = 'text';

  @Input()
  bool readonly = false;

  FnxText(@Optional() FnxForm form, @Optional() FnxInput wrapper) : super(form, wrapper);

  String get htmlType {
    switch(type) {
      case 'password':
      case 'number':
        return type;
      default:
        return 'text';
    }
  }

  static final RegExp _EMAIL_REGEXP = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  @override
  ngOnInit() {
    super.ngOnInit();
    assertType();
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

    } else {
      throw "This really should not happen: type=${type}";
    }
  }

  ///
  /// Is this a valid number within min/max limits?
  ///
  bool hasValidNumberImpl() {
    if (min == null && max == null) return true;
    num v = (value is num) ? value : num.parse(value, (_) => null);

    if (v == null && value != null && value.toString().length > 0) return false; // not a number
    if (required && v == null) return false;
    if (min != null && v < min) return false;
    if (max != null && v > max) return false;
    return true;
  }

  ///
  /// Is this valid text within maxLength and minLength limits?
  /// Is it valdi email or http URI?
  ///
  bool hasValidTextImpl() {
    if (minLength == null && maxLength == null && type == "text") return true;
    String v = (value is String) ? value : value.toString();

    if (required && v.length == 0) return false;
    if (minLength != null && v.length < minLength) return false;
    if (maxLength != null && v.length > maxLength) return false;

    if (type == "http") {
      // TODO: this parsing might be expensive, we should cache results
      try {
        Uri u = Uri.parse(v);
        String scheme = u.scheme.toLowerCase();
        if (scheme != "http" && scheme != "https") return false;

        if ((u.host == null || u.host.isEmpty) && (u.path == null || u.path.isEmpty)) return false;
        return true;

      } catch (e) {
        return false;
      }
    }

    if (type == "email") {
      return _EMAIL_REGEXP.hasMatch(v);
    }
    return true;
  }

  void assertType() {
    if (type != "text"
        && type != "number"
        && type != "email"
        && type != "http"
        && type != "password") {
      throw "The only possible types at this moment are 'text', 'number', 'email', 'http' and 'password'";
    }
  }
}
