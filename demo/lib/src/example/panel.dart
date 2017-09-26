import 'package:angular2/core.dart';

@Component(
  selector: 'panel-example',
  template: '''
  <documentation [componentTag]="'fnx-panel'"></documentation>

  <h1>Demo</h1>

  <demo label="Standalone">
    <fnx-panel>
      <h3 header>Heading</h3>
      <div main>Content of panel</div>
    </fnx-panel>
  </demo>

  <demo label="Closable panel">
    <fnx-panel [closable]="true" [open]="true">
      <h3 header>Heading</h3>
      <div main>Content of panel</div>
    </fnx-panel>
  </demo>

  <demo label="Closed closable panel">
    <fnx-panel [closable]="true" [open]="false">
      <h3 header>Heading</h3>
      <div main>Content of panel</div>
    </fnx-panel>
  </demo>
  ''',
)
class PanelExample {}
