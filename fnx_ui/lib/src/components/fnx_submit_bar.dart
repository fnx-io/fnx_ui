import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/util/global_messages.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;

///
/// Standardized set of buttons at the bottom of the `fnx-form`. Renders submit button which is enabled only if the
/// form is valid (= all components in the form are valid).
///
/// Use `[back]="true"` to enable standard back button.
///
/// Add custom buttons like this:
///
///         <fnx-submit-bar [back]="true">
///             <button class="btn" type="button" (click)="doSt($event)">Special action</button>
///         </fnx-submit-bar>
///
/// BUT don't forget to prevent $event from bubbling in you doSt method, otherwise the form would be submitted as well.
///
/// Custom buttons are aligned to left (next to back button).
///
@Component(
    selector: 'fnx-submit-bar',
    template: r'''
<div class="buttonbar">
  <a *ngIf="back" href="#" class="btn " (click)="goBack($event)" data-prefix="arrow_back">{{ goBackLabel }}</a>
  <ng-content></ng-content>
  <span class="spacer"></span>
  <button type="submit" 
          class="btn bg--important" 
          attr.data-prefix="{{ formValid ? 'check' : 'not_interested' }}" 
          [disabled]="form?.disabled == true"
          [class.opacity--07]="form?.disabled == true"
          [class.disabled]="form?.disabled == true">
    {{ label }}
  </button>
</div>
''',
  preserveWhitespace: false,
  directives: [
    coreDirectives,
    formDirectives,
  ],
)
class FnxSubmitBar implements AfterContentChecked {

  ///
  /// Input - use it to change label on submit button.
  ///
  @Input() String label = GlobalMessages.formSubmitLabelMessage();

  ///
  /// Input - use it to change label on back button.
  ///
  @Input() String goBackLabel = GlobalMessages.formBackLabelMessage();

  ///
  /// Input - Is back button allowed
  ///
  @Input() bool back = false;

  FnxForm get form => _form;

  final FnxForm _form;

  bool _checkedFormValid = true;

  FnxSubmitBar(@Optional() this._form) {
    if (_form == null) {
      throw new Exception("To use fnx-submit-bar, please wrap your form into <fnx-form></fnx-form> component!");
    }
  }

  bool get formValid {
    return _checkedFormValid;
  }

  void goBack(Event event) {
    ui.killEvent(event);
    window.history.back();
  }

  @override
  void ngAfterContentChecked(){
    _checkedFormValid = (_form == null)?true:_form.isValid();
  }
  
}