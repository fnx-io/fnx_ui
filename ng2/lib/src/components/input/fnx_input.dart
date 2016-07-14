import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:async';

@Component(
    selector: 'fnx-input',
    template: r'''
<div class="input">
  <label *ngIf="label != null" for="{{ componentId }}">{{ label }}</label>
  <ng-content></ng-content>
  <label *ngIf="hasError() && errorMessage != null" class="error" for="{{ componentId }}">{{ errorMessage }}</label>
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

  bool hasError() {
    return error;
  }

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

abstract class FnxInputComponent implements OnInit {

  FnxInput _wrapper;

  final String _privComponentId = ui.uid("comp_");

  final EventEmitter errorStateChange = new EventEmitter();

  FnxInputComponent(@Optional() FnxInput wrapper) {
    this._wrapper = wrapper;
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
      _wrapper.component = this;
    }
  }
}

const FNX_INPUT_DIRECTIVES = const [FnxInput];
