import 'package:angular2/core.dart';

@Component(
  selector: 'textarea-example',
  template: '''
  <documentation [componentTag]="'fnx-textarea'"></documentation>

  <h2>Demo</h2>

  <demo header="Standalone">
    <fnx-textarea></fnx-textarea>
  </demo>

  <demo header="Min and max characters <5; 10>">
    <fnx-textarea [minLength]="5" [maxLength]="10"></fnx-textarea>
  </demo>

  <demo header="Required">
    <fnx-input>
      <fnx-textarea [required]="true"></fnx-textarea>
    </fnx-input>
  </demo>

  <demo header="Read only">
    <fnx-textarea ngModel="My textarea" [readonly]="true"></fnx-textarea>
  </demo>
  ''',
)
class TextareaExample {}
