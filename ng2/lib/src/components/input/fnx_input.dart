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
  @Input() String errorMessage;

  bool error = false;

  StreamSubscription _errorSubscription;

  bool hasError() {
    return error;
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
    }
  }
}

abstract class FnxInputComponent implements OnInit {

  final FnxInput _wrapper;

  final String _privComponentId = ui.uid("comp_");

  final EventEmitter errorStateChange = new EventEmitter();

  FnxInputComponent(this._wrapper);

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
