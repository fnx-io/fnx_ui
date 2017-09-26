import 'package:angular2/core.dart';

@Component(
  selector: 'alert-example',
  template: '''
  <documentation [componentTag]="'fnx-alert'"></documentation>

  <h1>Demo</h1>

  <demo label="Alert of type 'info'" code='<fnx-alert type="info">Lorem ipsum.</fnx-alert>'>
    <fnx-alert type="info">Lorem ipsum.</fnx-alert>
  </demo>

  <demo label="Alert of type 'warning'">
    <fnx-alert type="warning">Lorem ipsum.</fnx-alert>
  </demo>

  <demo label="Alert of type 'error'">
    <fnx-alert type="error">Lorem ipsum.</fnx-alert>
  </demo>

  <demo label="Alert of type 'success'">
    <fnx-alert type="success">Lorem ipsum.</fnx-alert>
  </demo>

  <demo label="Non-closable alert">
    <fnx-alert type="info" [closable]="false">Lorem ipsum.</fnx-alert>
  </demo>

  <demo label="Custom icon">
    <fnx-alert type="info" icon="code">Lorem ipsum.</fnx-alert>
  </demo>

  <demo label="Custom color class">
    <fnx-alert type="info" colorClass="bg--pink">Lorem ipsum.</fnx-alert>
  </demo>
  ''',
)
class AlertExample {}
