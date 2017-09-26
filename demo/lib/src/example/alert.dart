import 'package:angular2/core.dart';

@Component(
  selector: 'alert-example',
  template: '''
  <documentation [componentTag]="'fnx-alert'"></documentation>

  <h2>Demo</h2>

  <demo header="Alert of type 'info'" code='<fnx-alert type="info">Lorem ipsum.</fnx-alert>'>
    <fnx-alert type="info">Lorem ipsum.</fnx-alert>
  </demo>

  <demo header="Alert of type 'warning'">
    <fnx-alert type="warning">Lorem ipsum.</fnx-alert>
  </demo>

  <demo header="Alert of type 'error'">
    <fnx-alert type="error">Lorem ipsum.</fnx-alert>
  </demo>

  <demo header="Alert of type 'success'">
    <fnx-alert type="success">Lorem ipsum.</fnx-alert>
  </demo>

  <demo header="Closable alert">
    <fnx-alert type="info" [closable]="false">Lorem ipsum.</fnx-alert>
  </demo>

  <demo header="Custom icon">
    <fnx-alert type="info" icon="code">Lorem ipsum.</fnx-alert>
  </demo>

  <demo header="Custom color class">
    <fnx-alert type="info" colorClass="bg--pink">Lorem ipsum.</fnx-alert>
  </demo>
  ''',
)
class AlertExample {}
