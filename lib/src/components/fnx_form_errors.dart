import 'package:angular/angular.dart';
import 'package:fnx_ui/fnx_ui.dart';

///
///
@Component(
    selector: 'fnx-form-errors',
    template: r'''
<ul class="ul--flat text--red margin--bottom" *ngIf="form.errorMessages.isNotEmpty">
    <li class="item" data-prefix="error" *ngFor="let error of form.errorMessages" >{{error}}</li>
</ul>
''',
  preserveWhitespace: false
)
class FnxFormErrors {

  final FnxForm form;

  FnxFormErrors(@Optional() this.form) {
    if (form == null) {
      throw new Exception("To use fnx-form-errors, please wrap your form into <fnx-form></fnx-form> component!");
    }
  }
}
