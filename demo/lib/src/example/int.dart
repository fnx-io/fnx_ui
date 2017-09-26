import 'package:angular2/core.dart';

@Component(
  selector: 'int-example',
  template: '''
  <documentation [componentTag]="'fnx-int'"></documentation>

  <h1>Demo</h1>

  <demo label="Standalone">
    <fnx-int></fnx-int>
  </demo>

  <demo label="Min and max <5; 10>">
    <fnx-int [min]="5" [max]="10"></fnx-int>
  </demo>

  <demo label="Placeholder">
    <fnx-int placeholder="Awesome integer"></fnx-int>
  </demo>

  <demo label="Required">
    <fnx-input>
      <fnx-int [required]="true"></fnx-int>
    </fnx-input>
  </demo>

  <demo label="Read only">
    <fnx-int [ngModel]="7" [readonly]="true"></fnx-int>
  </demo>
  ''',
)
class IntExample {}
