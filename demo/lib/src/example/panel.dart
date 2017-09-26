import 'package:angular2/core.dart';

@Component(
  selector: 'panel-example',
  template: '''
  <documentation [componentTag]="'fnx-panel'"></documentation>

  <h2>Demo</h2>

  <demo header="Standalone">
    <fnx-panel>
      <h3 header>Heading</h3>
      <div main>Content of panel</div>
    </fnx-panel>
  </demo>

  <demo header="Closable panel">
    <fnx-panel [closable]="true" [open]="true">
      <h3 header>Heading</h3>
      <div main>Content of panel</div>
    </fnx-panel>
  </demo>

  <demo header="Closed closable panel">
    <fnx-panel [closable]="true" [open]="false">
      <h3 header>Heading</h3>
      <div main>Content of panel</div>
    </fnx-panel>
  </demo>
  ''',
)
class PanelExample {}
