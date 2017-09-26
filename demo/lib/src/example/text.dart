import 'package:angular2/core.dart';

@Component(
  selector: 'text-example',
  template: '''
  <documentation [componentTag]="'fnx-text'"></documentation>

  <h1>Demo</h1>

  <demo label="Standalone">
    <fnx-text></fnx-text>
  </demo>

  <demo label="Min and max characters <5; 10>">
    <fnx-text [minLength]="5" [maxLength]="10"></fnx-text>
  </demo>

  <demo label="Placeholder">
    <fnx-text placeholder="Awesome text"></fnx-text>
  </demo>

  <demo label="Required">
    <fnx-input>
      <fnx-text [required]="true"></fnx-text>
    </fnx-input>
  </demo>

  <demo label="Read only">
    <fnx-text ngModel="My text" [readonly]="true"></fnx-text>
  </demo>
  ''',
)
class TextExample {}
