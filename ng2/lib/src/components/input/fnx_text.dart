import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';


const CUSTOM_INPUT_TEXT_VALUE_ACCESSOR = const Provider(  NG_VALUE_ACCESSOR,
                                                          useExisting: FnxText,
                                                          multi: true);

@Component(
    selector: 'fnx-text',
    template: r'''
<input id="{{ componentId }}" type="text" [(ngModel)]="value"/>
''',
    providers: const [CUSTOM_INPUT_TEXT_VALUE_ACCESSOR]
)
class FnxText extends FnxInputComponent implements ControlValueAccessor, OnInit {

  dynamic _value;
  @Output() EventEmitter valueChange = new EventEmitter();

  bool error = false;

  @ContentChild(NgFormControl) NgFormControl state;

  FnxText(@Optional() FnxInput wrapper): super(wrapper);

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

  @override
  ngOnInit() {
    super.ngOnInit();
  }

  var onChange = (_) {};
  var onTouched = (_) {};

  void checkErrors() {
    error = state != null && !state.valid;
    errorStateChange.emit(error);
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

const FNX_INPUT_TEXT_DIRECTIVES = const [FnxText];