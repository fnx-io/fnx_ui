import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:angular2/src/common/forms/directives/validators.dart';


const CUSTOM_INPUT_TEXT_VALUE_ACCESSOR = const Provider(  NG_VALUE_ACCESSOR,
                                                          useExisting: FnxText,
                                                          multi: true);

@Component(
    selector: 'fnx-text',
    template: r'''
<input id="{{ componentId }}" type="{{ type }}" [(ngModel)]="value"/>
''',
    providers: const [CUSTOM_INPUT_TEXT_VALUE_ACCESSOR]
)
class FnxText extends FnxInputComponent implements ControlValueAccessor, OnInit, AfterViewInit {

  dynamic _value;
  @Output() EventEmitter valueChange = new EventEmitter();

  bool formError = false;

  @Input() bool required = false;
  @Input() int minLength = null;
  @Input() int maxLength = null;
  @Input() String type = 'text';

  @ContentChild(NgControl) NgControl formControl;

  FnxText(@Optional() FnxInput wrapper, @Optional() NgForm form): super(wrapper, form);

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
    formError = formControl != null && !formControl.valid;
    errorStateChange.emit(formError);
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

  NgForm getForm() {
    return form;
  }

  bool requiredValidation() {
    return required;
  }

  int minLengthValidation() {
    return minLength;
  }

  int maxLengthValidation() {
    return maxLength;
  }

  @override
  ngAfterViewInit() {
    super.ngAfterViewInit();
  }

  @override
  ngOnInit() {
    super.ngOnInit();
  }
}

const FNX_INPUT_TEXT_DIRECTIVES = const [FnxText];