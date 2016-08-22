import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:async';
import 'package:angular2/src/common/forms/directives/validators.dart';
import 'package:fnx_ui/src/validator.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
    selector: 'fnx-input',
    template: r'''
<div class="input">
  <label *ngIf="label != null"
    [attr.for]="componentId"
    [class.required]="hasRequiredChildren()"
    (click)="markAsTouched()">{{ label }}</label>
  <ng-content></ng-content>
  <label *ngIf="isTouchedAndInvalid()" class="error" [attr.for]="componentId">{{ errorMessage }}</label>
</div>
''')
class FnxInput extends FnxValidatorComponent {

  final String componentId = ui.uid('comp_');

  @Input() String label;
  String _errorMessage;

  @Input()
  void set errorMessage(String err) {
    this._errorMessage = err;
  }

  String get errorMessage {
    return _errorMessage == null ? "Error" : _errorMessage;
  }

  @override
  bool hasValidValue() {
    return true;
  }

}

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
    if (v != this._value) {
      this._value = v;
      notifyChange();
      this.valueChange.emit(v);
    }
  }

  void notifyChange() {
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
    notifyChange();
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

}

const FNX_INPUT_DIRECTIVES = const [FnxInput];
