import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:angular2/src/common/forms/directives/validators.dart';
import 'package:fnx_ui/src/validator.dart';

const CUSTOM_INPUT_TEXT_VALUE_ACCESSOR = const Provider(  NG_VALUE_ACCESSOR,
    useExisting: FnxText,
    multi: true);
@Component(
    selector: 'fnx-text',
    template: r'''
<input id="{{ componentId }}" type="{{ type }}" [(ngModel)]="value" [readonly]="readonly"
(focus)="markAsTouched()"
(click)="markAsTouched()"
[class.error]="isTouchedAndInvalid()"
  />
''',
    providers: const [CUSTOM_INPUT_TEXT_VALUE_ACCESSOR]
)
class FnxText extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy {

  @Input() bool required = false;
  @Input() int minLength = null;
  @Input() int maxLength = null;
  @Input() String type = 'text';
  @Input() bool readonly = false;

  FnxText(@Optional() FnxForm form, @Optional() FnxInput wrapper): super(form, wrapper);

  @override
  bool hasValidValue() {
    if (required) {
      if (value == null) return false;
      if (type == 'text' && value.toString().isEmpty) return false;
    }
    return true;
  }

}