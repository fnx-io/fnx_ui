import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:async';
import 'package:angular2/src/common/forms/directives/validators.dart';

@Component(
    selector: 'fnx-input',
    template: r'''
<div class="input">
  <label *ngIf="label != null" [attr.for]="componentId">{{ label }}</label>
  <ng-content></ng-content>
  <label *ngIf="error && errorMessage != null" class="error" [attr.for]="componentId">{{ errorMessage }}</label>
</div>
''')
class FnxInput {

  final String componentId = ui.uid('comp_');

  FnxInputComponent _component;

  @Input() String label;
  String _errorMessage;
  String _customErrorMessage;

  bool error = false;

  StreamSubscription _errorSubscription;

  @Input()
  void set errorMessage(String err) {
    this._errorMessage = err;
  }


  String get errorMessage {
    return _customErrorMessage != null ? _customErrorMessage : _errorMessage;
  }

  FnxInputComponent get component => _component;

  void set component(FnxInputComponent component) {

    if (_errorSubscription != null) _errorSubscription.cancel();
    this._component = component;
    if (component != null) {
      _errorSubscription = component.errorStateChange.listen(handleErrorChange);
    }
  }

  handleErrorChange(dynamic errorStatus) {
    if (errorStatus is bool) {
      this.error = errorStatus;
      if (!errorStatus) {
        _customErrorMessage = null;
      }
    } else if (errorStatus is String) {
      error = true;
      _customErrorMessage = errorStatus;
    } else if (errorStatus == null) {
      error = false;
      _customErrorMessage = null;
    }
  }
}

abstract class FnxInputComponent implements OnInit, AfterViewInit {

  FnxInput _wrapper;
  NgForm form;

  final String _privComponentId = ui.uid("comp_");

  final EventEmitter errorStateChange = new EventEmitter();

  Control componentControl;

  FnxInputComponent(@Optional() FnxInput wrapper, @Optional() NgForm form) {
    this._wrapper = wrapper;
    this.form = form;
  }

  String get componentId {
    if (_wrapper != null) {
      return _wrapper.componentId;
    } else {
      return _privComponentId;
    }
  }

  /// flag that model of this input is required
  bool requiredValidation() => false;
  int minLengthValidation() => null;
  int maxLengthValidation() => null;

  /// Implement this to add custom validators to the input's control
  List<ValidatorFn> getCustomValidators() {
    return [];
  }

  @override
  ngOnInit() {
    if (_wrapper != null) {
      _wrapper.component = this;
    }
  }

  @override
  ngAfterViewInit() {
    List<ValidatorFn> validators = [];
    if (requiredValidation()) {
      validators.add(Validators.required);
    }
    if (minLengthValidation() != null) {
      validators.add(Validators.minLength(minLengthValidation()));
    }
    if (maxLengthValidation() != null) {
      validators.add(Validators.maxLength(maxLengthValidation()));
    }
    var customValidators = getCustomValidators();
    if (customValidators != null && customValidators.isNotEmpty) {
      validators.addAll(customValidators);
    }
    if (validators.isNotEmpty) {
      componentControl = new Control('', Validators.compose(validators));
      if (form != null) {
        form.control.addControl(componentId, componentControl);
      }
    }
  }


}

const FNX_INPUT_DIRECTIVES = const [FnxInput];
