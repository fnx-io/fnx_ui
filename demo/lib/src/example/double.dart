import 'package:angular2/core.dart';

@Component(
  selector: 'double-example',
  template: '''
  <documentation [componentTag]="'fnx-double'"></documentation>

  <h2>Demo</h2>

  <demo header="Standalone">
    <fnx-double></fnx-double>
  </demo>

  <demo header="Min and max <5; 10>">
    <fnx-double [min]="5" [max]="10"></fnx-double>
  </demo>

  <demo header="Step">
    <fnx-double [step]="5"></fnx-double>
  </demo>

  <demo header="Placeholder">
    <fnx-double placeholder="My double value"></fnx-double>
  </demo>

  <demo header="Required">
    <fnx-double [required]="true"></fnx-double>
  </demo>

  <demo header="Read only">
    <fnx-double [ngModel]="12.6976" [readonly]="true"></fnx-double>
  </demo>
  ''',
)
class DoubleExample {}
