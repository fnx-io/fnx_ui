import 'package:angular2/core.dart';
import 'package:angular2/common.dart';

@Component(
    selector: 'fnx-input',
    templateUrl: 'fnx_input.html'
)
class FnxInput {

  dynamic _value;
  @Output()
  EventEmitter valueChange = new EventEmitter();

  @Input()
  set value(dynamic val) {
    _value = val;
    valueChange.emit(val);
  }
  get value => _value;
}

const FNX_INPUT_DIRECTIVES = const [FnxInput];