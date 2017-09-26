import 'package:angular2/core.dart';

@Component(
  selector: 'submit-bar-example',
  template: '''
  <documentation [componentTag]="'fnx-submit-bar'"></documentation>

  <demo label="Standalone">
    <fnx-form>
      <fnx-input label="Fill this int">
        <fnx-int [required]="true" placeholder="Required int input"></fnx-int>
      </fnx-input>

      <fnx-submit-bar></fnx-submit-bar>
    </fnx-form>
  </demo>

  <demo label="Back button">
    <fnx-form>
      <fnx-input label="Fill this int">
        <fnx-int [required]="true" placeholder="Required int input"></fnx-int>
      </fnx-input>

      <fnx-submit-bar [back]="true"></fnx-submit-bar>
    </fnx-form>
  </demo>

  <demo label="Custom labels">
    <fnx-form>
      <fnx-input label="Fill this int">
        <fnx-int [required]="true" placeholder="Required int input"></fnx-int>
      </fnx-input>

      <fnx-submit-bar [back]="true" label="Custom label" goBackLabel="Custom goBack label"></fnx-submit-bar>
    </fnx-form>
  </demo>
  ''',
)
class SubmitBarExample {}
