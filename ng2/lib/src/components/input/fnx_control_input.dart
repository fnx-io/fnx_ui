import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart';


const CUSTOM_INPUT_CONTROL_VALUE_ACCESSOR = const Provider( NG_VALUE_ACCESSOR,
                                                            useExisting: FnxControlInput,
                                                            multi: true);


@Component(
    selector: 'fnx-control-input',
    templateUrl: 'fnx_control_input.html',
    providers: const [CUSTOM_INPUT_CONTROL_VALUE_ACCESSOR]
)
class FnxControlInput implements ControlValueAccessor {

  final String id = uid('input_');

  dynamic _value;

  @Input()
  String label = null;

  @Input()
  String errorMsg = null;

  bool error = false;

  @Output()
  EventEmitter valueChange = new EventEmitter();

  @ContentChild(NgFormControl) NgFormControl state;

  get value => _value;

  @Input()
  set value(dynamic v) {
    if (v != this._value) {
      this._value = v;
      this.onChange(v);
      this.valueChange.emit(v);
      checkErrors();
    }
  }

  var onChange = (_) {};
  var onTouched = (_) {};

  void checkErrors() {
    error = state != null && !state.valid;
  }

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
    onChange(obj);
  }
}

const FNX_INPUT_CONTROL_DIRECTIVES = const [FnxControlInput];