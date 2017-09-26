import 'package:angular2/core.dart';

@Component(
  selector: 'formatted-double-example',
  template: '''
  <documentation [componentTag]="'fnx-formatted-double'"></documentation>

  <h2>Demo</h2>

  <demo header="Standalone">
    <fnx-formatted-double></fnx-formatted-double>
  </demo>

  <demo header="Min and max <5; 10>">
    <fnx-formatted-double [min]="5" [max]="10"></fnx-formatted-double>
  </demo>

  <demo header="Step">
    <fnx-formatted-double [step]="5"></fnx-formatted-double>
  </demo>

  <demo header="Placeholder">
    <fnx-formatted-double placeholder="My double value"></fnx-formatted-double>
  </demo>

  <demo header="Required">
    <fnx-formatted-double [required]="true"></fnx-formatted-double>
  </demo>

  <demo header="Read only">
    <fnx-formatted-double [ngModel]="12.6976" [readonly]="true"></fnx-formatted-double>
  </demo>

  <demo header="Custom format">
    <fnx-formatted-double [ngModel]="123456.123" format="#,##0.000"></fnx-formatted-double>
  </demo>
  ''',
)
class FormattedDoubleExample {}
