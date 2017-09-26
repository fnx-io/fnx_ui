import 'package:angular2/core.dart';

@Component(
  selector: 'date-example',
  template: '''
  <documentation [componentTag]="'fnx-date'"></documentation>

  <h1>Demo</h1>

  <demo label="Standalone">
    <fnx-date></fnx-date>
  </demo>

  <demo label="Date and time">
    <fnx-date [dateTime]="true"></fnx-date>
  </demo>

  <demo label="Required">
    <fnx-date [required]="true"></fnx-date>
  </demo>

  <demo label="Required inside fnx-input">
    <fnx-input label="My required date">
      <fnx-date [required]="true"></fnx-date>
    </fnx-input>
  </demo>

  <demo label="Read only">
    <fnx-date [(ngModel)]="value" [readonly]="true"></fnx-date>
  </demo>
  ''',
)
class DateExample {
  DateTime value = new DateTime.now();
}
