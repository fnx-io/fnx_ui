import 'package:angular2/core.dart';

@Component(
  selector: 'text-example',
  template: '''
  <documentation [componentTag]="'fnx-text'"></documentation>

  <h2>Demo</h2>

  <demo header="Standalone">
    <fnx-text></fnx-text>
  </demo>

  <demo header="Min and max characters <5; 10>">
    <fnx-text [minLength]="5" [maxLength]="10"></fnx-text>
  </demo>

  <demo header="Placeholder">
    <fnx-text placeholder="Awesome text"></fnx-text>
  </demo>

  <demo header="Required">
    <fnx-input>
      <fnx-text [required]="true"></fnx-text>
    </fnx-input>
  </demo>

  <demo header="Read only">
    <fnx-text ngModel="My text" [readonly]="true"></fnx-text>
  </demo>
  ''',
)
class TextExample {}
