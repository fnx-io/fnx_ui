import 'package:angular2/core.dart';

@Component(
  selector: 'double-example',
  template: '''
  <documentation [componentTag]="'fnx-double'"></documentation>

  <h1>Demo</h1>

  <demo label="Standalone">
    <fnx-double></fnx-double>
  </demo>

  <demo label="Min and max <5; 10>">
    <fnx-double [min]="5" [max]="10"></fnx-double>
  </demo>

  <demo label="Step">
    <fnx-double [step]="5"></fnx-double>
  </demo>

  <demo label="Placeholder">
    <fnx-double placeholder="My double value"></fnx-double>
  </demo>

  <demo label="Required">
    <fnx-double [required]="true"></fnx-double>
  </demo>

  <demo label="Read only">
    <fnx-double [ngModel]="12.6976" [readonly]="true"></fnx-double>
  </demo>
  ''',
)
class DoubleExample {}
