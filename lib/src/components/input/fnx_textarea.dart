import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/validator.dart';

const CUSTOM_INPUT_TEXTAREA_VALUE_ACCESSOR = const Provider(NG_VALUE_ACCESSOR, useExisting: FnxTextarea, multi: true);

@Component(
  selector: 'fnx-textarea',
  template: r'''
<textarea id="{{ componentId }}" [(ngModel)]="value" [readonly]="isReadonly"
(focus)="markAsTouched()"
(click)="markAsTouched()" #textarea></textarea>
''',
  styles: const ["textarea { height: 100%}"],
  providers: const [
    CUSTOM_INPUT_TEXTAREA_VALUE_ACCESSOR,
    const Provider(Focusable, useExisting: FnxTextarea, multi: false),
    const Provider(FnxValidatorComponent, useExisting: FnxTextarea, multi: false),
  ],
  preserveWhitespace: false,
)
class FnxTextarea extends FnxText implements OnInit, OnDestroy, Focusable {
  @Input()
  bool required = false;
  @Input()
  int minLength = null;
  @Input()
  int maxLength = null;
  @Input()
  bool readonly = false;

  @ViewChild("textarea")
  ElementRef elementRef;

  FnxTextarea(@SkipSelf() @Optional() FnxValidatorComponent parent) : super(parent) {
    type = "text";
  }

  @override
  void focus() {
    if (elementRef != null && elementRef.nativeElement != null) {
      elementRef.nativeElement.focus();
    }
  }

  @override
  bool get disabled => false;
}
