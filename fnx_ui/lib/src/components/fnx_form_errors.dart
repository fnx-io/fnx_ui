import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';

///
///
@Component(
  selector: 'fnx-form-errors',
  template: r'''
<ul class="ul--flat text--red margin--bottom" *ngIf="form.errorMessages.isNotEmpty">
    <li class="item" [attr.data-prefix]="'error'" *ngFor="let error of form.errorMessages" >{{error}}</li>
</ul>
''',
  preserveWhitespace: false,
  directives: [
    coreDirectives,
    formDirectives,
  ],
)
class FnxFormErrors {
  final FnxForm form;

  FnxFormErrors(this.form);
}
