import 'package:angular2/core.dart';

@Component(
  selector: 'panel-small-example',
  template: '''
  <documentation [componentTag]="'fnx-panel-small'"></documentation>

  <h1>Demo</h1>

  <demo label="Standalone">
    <fnx-panel-small>
      <h3 header>Heading</h3>
      <div main>Content of panel</div>
    </fnx-panel-small>
  </demo>

  <demo label="Closable panel">
    <fnx-panel-small [closable]="true" [open]="true">
      <h3 header>Heading</h3>
      <div main>Content of panel</div>
    </fnx-panel-small>
  </demo>

  <demo label="Closed closable panel">
    <fnx-panel-small [closable]="true" [open]="false">
      <h3 header>Heading</h3>
      <div main>Content of panel</div>
    </fnx-panel-small>
  </demo>
  ''',
)
class PanelSmallExample {}
