import 'package:angular2/core.dart';

@Component(
  selector: 'textarea-example',
  template: '''
  <documentation [componentTag]="'fnx-textarea'"></documentation>

  <h1>Demo</h1>

  <demo label="Standalone">
    <fnx-textarea></fnx-textarea>
  </demo>

  <demo label="Min and max characters <5; 10>">
    <fnx-textarea [minLength]="5" [maxLength]="10"></fnx-textarea>
  </demo>

  <demo label="Required">
    <fnx-input>
      <fnx-textarea [required]="true"></fnx-textarea>
    </fnx-input>
  </demo>

  <demo label="Read only">
    <fnx-textarea ngModel="My textarea" [readonly]="true"></fnx-textarea>
  </demo>
  ''',
)
class TextareaExample {}
