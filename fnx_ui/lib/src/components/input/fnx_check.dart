import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/validator.dart';

const CUSTOM_INPUT_CHECK_VALUE_ACCESSOR = const Provider(ngValueAccessor, useExisting: FnxCheck);

@Component(
  selector: 'fnx-check',
  template: r'''
<span class="check">
    <input type="checkbox" attr.id="{{componentId}}" [(ngModel)]="value"
    (focus)="markAsTouched()"
    (click)="markAsTouched()"
    [disabled]="disabled || isReadonly"
    [class.disabled]="disabled || isReadonly"
    [attr.tabindex]="(isReadonly || isDisabled) ? '-1' : '0'"    
    ><label attr.for="{{componentId}}"
    (focus)="markAsTouched()"
    (click)="markAsTouched()"
    >{{label}}</label>
</span>
''',
  providers: const [
    CUSTOM_INPUT_CHECK_VALUE_ACCESSOR,
    const Provider(FnxValidatorComponent, useExisting: FnxCheck),
  ],
  directives: [coreDirectives, formDirectives],
  preserveWhitespace: false,
)
class FnxCheck extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy {
  @Input()
  bool required = false;

  @Input()
  bool readonly = false;

  @Input()
  @override
  bool disabled = false;

  @Input()
  String? label;

  FnxCheck(@SkipSelf() @Optional() FnxValidatorComponent? parent) : super(parent);

  @override
  bool hasValidValue() {
    if (required) {
      if (value == null) return false;
      if (value == false) return false;
    }
    return true;
  }
}
