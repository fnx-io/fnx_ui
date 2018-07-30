import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/src/util/global_messages.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:fnx_ui/src/validator.dart';
import 'package:logging/logging.dart';

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
  preserveWhitespace: false,
  visibility: Visibility.all,
  providers: const [
    const Provider(FnxValidatorComponent, useExisting: FnxInput, multi: false),
  ],
  directives: [
    coreDirectives,
    formDirectives,
  ],
)
class FnxInput extends FnxValidatorComponent implements OnInit, OnDestroy {

  static final Logger log = new Logger("FnxInput");

  FnxInput(@SkipSelf() @Optional() FnxValidatorComponent parent) : super(parent);

  final String componentId = ui.uid('comp_');

  @Input()
  String label;
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
    log.shout("You are setting 'readonly' attribute to fnx-input, that's not what you want");
//    throw "You are setting 'readonly' attribute to fnx-input, that's not what you want";
  }

  bool get required => _required;

  @Input()
  set required(bool value) {
     log.shout("You are setting 'required' attribute to fnx-input, that's not what you want");
//    throw "You are setting 'required' attribute to fnx-input, that's not what you want";
  }

  @override
  bool get disabled => false;
}

///
/// Ads support for custom validation and ngModel.
///
abstract class FnxInputComponent<T> extends FnxValidatorComponent implements OnInit, OnDestroy, ControlValueAccessor<T> {
  final String _privComponentId = ui.uid("comp_");

  Control componentControl;

  FnxValidatorComponent _parent;
  FnxInputComponent(this._parent) : super(_parent);

  T _value;

  T get value => _value;

  void set disabled(bool disabled); // abstract

  StreamController<T> _valueChanged = new StreamController();
  @Output()
  Stream<T> get valueChange => _valueChanged.stream;

  @Input()
  set value(T v) {
    if (v == "") v = null; // TODO: is it a good idea?
    if (v != this._value) {
      this._value = v;
      this._valueChanged.add(v);
      notifyNgModel();
    }
  }

  void notifyNgModel() {
    if (onChange != null) {
      onChange(_value);
    }
  }

  ChangeFunction<T> onChange = (T t, {String rawValue}) {};
  TouchFunction onTouched = () {};

  @override
  void registerOnChange(ChangeFunction<T> f) {
    this.onChange = f;
  }

  @override
  void registerOnTouched(TouchFunction fn) {
    this.onTouched = fn;
  }


  @override
  void onDisabledChanged(bool isDisabled) {
    disabled = isDisabled;
  }

  @override
  void writeValue(obj) {
    _value = obj;
    // notifyNgModel(); //we shouldn't do this, no need to notify NgModel about changes it already knows
  }

  String get componentId {
    if (_parent != null && _parent is FnxInput) {
      return (_parent as FnxInput).componentId;
    } else {
      return _privComponentId;
    }
  }
}
