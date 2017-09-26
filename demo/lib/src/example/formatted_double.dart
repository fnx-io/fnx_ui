import 'package:angular2/core.dart';

@Component(
  selector: 'formatted-double-example',
  template: '''
  <documentation [componentTag]="'fnx-formatted-double'"></documentation>

  <h1>Demo</h1>

  <demo label="Standalone">
    <fnx-formatted-double></fnx-formatted-double>
  </demo>

  <demo label="Min and max <5; 10>">
    <fnx-formatted-double [min]="5" [max]="10"></fnx-formatted-double>
  </demo>

  <demo label="Step">
    <fnx-formatted-double [step]="5"></fnx-formatted-double>
  </demo>

  <demo label="Placeholder">
    <fnx-formatted-double placeholder="My double value"></fnx-formatted-double>
  </demo>

  <demo label="Required">
    <fnx-formatted-double [required]="true"></fnx-formatted-double>
  </demo>

  <demo label="Read only">
    <fnx-formatted-double [ngModel]="12.6976" [readonly]="true"></fnx-formatted-double>
  </demo>

  <demo label="Custom format">
    <fnx-formatted-double [ngModel]="123456.123" format="#,##0.000"></fnx-formatted-double>
  </demo>
  ''',
)
class FormattedDoubleExample {}
