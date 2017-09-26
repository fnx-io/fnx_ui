import 'package:angular2/core.dart';

@Component(
  selector: 'check-example',
  template: '''
  <documentation [componentTag]="'fnx-check'"></documentation>

  <h1>Demo</h1>

  <demo label="Standalone">
    <fnx-check></fnx-check>
  </demo>

  <demo label="Inside of fnx-input">
    <fnx-input label="Label from input">
      <fnx-check></fnx-check>
    </fnx-input>
  </demo>

  <demo label="Inside of fnx-input with own label">
    <fnx-input label="Label from input">
      <fnx-check label="My own label"></fnx-check>
    </fnx-input>
  </demo>

  <demo label="Multiple checkboxes">
    Each checkbox has to be in it's own &lt;fnx-input&gt;.

    <fnx-input>
      <fnx-check label="My first checkbox"></fnx-check>
    </fnx-input>
    <fnx-input>
      <fnx-check label="My second checkbox"></fnx-check>
    </fnx-input>
    <fnx-input>
      <fnx-check label="My third checkbox"></fnx-check>
    </fnx-input>
  </demo>

  <demo label="Required">
    <fnx-input label="Required checkbox">
      <fnx-check [required]="true"></fnx-check>
    </fnx-input>
  </demo>

  <demo label="Read only">
    <fnx-check [readonly]="true"></fnx-check>
  </demo>

  <demo label="Disabled">
    <fnx-check [disabled]="true"></fnx-check>
  </demo>
  ''',
)
class CheckExample {}
