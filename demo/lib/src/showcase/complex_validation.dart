import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'complex-validation-showcase',
  template: r'''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>

  <!--
    Complex validation rules are registered in the Dart component.
  -->
  <fnx-form (submit)="postRecord()" #validatedForm >
  
    <fnx-form-errors></fnx-form-errors>
  
    <!-- flex based grid -->
    <div class="row--gutter">
  
      <fnx-input label="One" class="s6">
          <fnx-text [(ngModel)]="record['one']"></fnx-text>
      </fnx-input>

      <fnx-input label="Two" class="s6">
          <fnx-text [(ngModel)]="record['two']"></fnx-text>
      </fnx-input>

    </div>
  
    <!-- smart submit button -->
    <fnx-submit-bar></fnx-submit-bar>
  
  </fnx-form>
  ''',
)
class ComplexValidationShowcase implements OnInit {

  Map record = {};

  FnxApp app;

  @ViewChild("validatedForm")
  FnxForm form;

  ComplexValidationShowcase(this.app);

  void postRecord() {
    print('yay');
    app.toast("Done!");
  }

  @override
  ngOnInit() {
    form.addValidator(customValidation);
  }

  String customValidation() {
    if (record['one'] == null || record['two'] == null) {
      return "Please fill both values";
    }

    if (record['one']!=record['two']) {
      return "Both values must be the same";
    }

    return null;
  }
}
