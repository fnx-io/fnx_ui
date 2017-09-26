import 'package:angular2/core.dart';

@Component(
  selector: 'int-example',
  template: '''
  <documentation [componentTag]="'fnx-int'"></documentation>

  <h2>Demo</h2>

  <demo header="Standalone">
    <fnx-int></fnx-int>
  </demo>

  <demo header="Min and max <5; 10>">
    <fnx-int [min]="5" [max]="10"></fnx-int>
  </demo>

  <demo header="Placeholder">
    <fnx-int placeholder="Awesome integer"></fnx-int>
  </demo>

  <demo header="Required">
    <fnx-input>
      <fnx-int [required]="true"></fnx-int>
    </fnx-input>
  </demo>

  <demo header="Read only">
    <fnx-int [ngModel]="7" [readonly]="true"></fnx-int>
  </demo>
  ''',
)
class IntExample {}
