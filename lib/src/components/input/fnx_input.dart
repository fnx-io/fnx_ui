import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/util/global_messages.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:fnx_ui/src/validator.dart';

@Component(
    selector: 'fnx-input',
    template: r'''
<div class="input">
  <label *ngIf="label != null"
    [attr.for]="componentId"
    [class.required]="hasRequiredChildren()"
    (click)="markAsTouched()" [innerHtml]="label"></label>
  <ng-content></ng-content>
  <label *ngIf="isTouchedAndInvalid()" class="error" [attr.for]="componentId">{{ errorMessage }}</label>
</div>
''',
    preserveWhitespace: false)
class FnxInput extends FnxValidatorComponent {

  final String componentId = ui.uid('comp_');

  @Input() String label;
  String _errorMessage;
  String _defaultErrorMessage;

  bool _required = false;
  bool _readonly = false;

  @Input()
  void set errorMessage(String err) {
    this._errorMessage = err;
  }

  String get errorMessage {
    if (_errorMessage != null) {
      return _errorMessage;
    } else if (_defaultErrorMessage != null) {
      return _defaultErrorMessage;
    } else {
      return GlobalMessages.inputGenericError();
    }
  }

  @override
  bool hasValidValue() {
    return true;
  }

  /// fields can have better default error message
  /// than the generic "Error" message
  set setDefaultErrorMessage(String msg) {
    _defaultErrorMessage = msg;
  }

  bool get readonly => _readonly;

  @Input()
  set readonly(bool value) {
    throw "You are setting 'readonly' attribute to fnx-input, that's not what you want";
  }

  bool get required => _required;

  @Input()
  set required(bool value) {
    throw "You are setting 'required' attribute to fnx-input, that's not what you want";
  }

  bool get isReadonly => (readonly??false);


}

///
/// Ads support for custom validation and ngModel.
///
abstract class FnxInputComponent extends FnxValidatorComponent implements OnInit, ControlValueAccessor {

  FnxInput _wrapper;
  FnxForm _form;

  final String _privComponentId = ui.uid("comp_");

  Control componentControl;

  FnxInputComponent(this._form, this._wrapper);

  dynamic _value;

  get value => _value;

  @Output() EventEmitter valueChange = new EventEmitter();

  @Input()
  set value(dynamic v) {
    if (v == "") v = null; // TODO: is it a good idea?
    if (v != this._value) {
      this._value = v;
      this.valueChange.emit(v);
      notifyNgModel();
    }
  }

  void notifyNgModel() {
    if (onChange != null) {
      onChange(_value);
    }
  }

  var onChange = (_) {};
  var onTouched = (_) {};

  @override
  void registerOnChange(fn) {
    this.onChange = fn;
  }

  @override
  void registerOnTouched(fn) {
    this.onTouched = fn;
  }

  @override
  void writeValue(obj) {
    _value = obj;
    // notifyNgModel(); //we shouldn't do this, no need to notify NgModel about changes it already knows
  }

  String get componentId {
    if (_wrapper != null) {
      return _wrapper.componentId;
    } else {
      return _privComponentId;
    }
  }

  @override
  ngOnInit() {
    if (_wrapper != null) {
      _wrapper.registerChild(this);
    }
    if (_form != null) {
      _form.registerChild(this);
    }
  }

  @override
  ngOnDestroy() {
    if (_wrapper != null) {
      _wrapper.deregisterChild(this);
    }
    if (_form != null) {
      _form.deregisterChild(this);
    }
  }

  bool get isParentReadonly {
    if (_wrapper != null && _wrapper.readonly) return true;
    if (_form != null && _form.readonly) return true;
    return false;
  }

  bool get isReadonly => (readonly??false) || isParentReadonly;

}

const FNX_INPUT_DIRECTIVES = const [FnxInput];
