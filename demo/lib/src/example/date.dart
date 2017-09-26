import 'package:angular2/core.dart';

@Component(
  selector: 'date-example',
  template: '''
  <documentation [componentTag]="'fnx-date'"></documentation>

  <h2>Demo</h2>

  <demo header="Standalone">
    <fnx-date></fnx-date>
  </demo>

  <demo header="Date and time">
    <fnx-date [dateTime]="true"></fnx-date>
  </demo>

  <demo header="Required">
    <fnx-date [required]="true"></fnx-date>
  </demo>

  <demo header="Read only">
    <fnx-date [(ngModel)]="value" [readonly]="true"></fnx-date>
  </demo>
  ''',
)
class DateExample {
  DateTime value = new DateTime.now();
}
