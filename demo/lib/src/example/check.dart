import 'package:angular2/core.dart';

@Component(
  selector: 'check-example',
  template: '''
  <documentation [componentTag]="'fnx-check'"></documentation>

  <h2>Demo</h2>

  <demo header="Standalone">
    <fnx-check></fnx-check>
  </demo>

  <demo header="Inside of fnx-input">
    <fnx-input label="Label from input">
      <fnx-check></fnx-check>
    </fnx-input>
  </demo>

  <demo header="Inside of fnx-input with own label">
    <fnx-input label="Label from input">
      <fnx-check label="My own label"></fnx-check>
    </fnx-input>
  </demo>

  <demo header="Multiple checkboxes">
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

  <demo header="Required">
    <fnx-input label="Required checkbox">
      <fnx-check [required]="true"></fnx-check>
    </fnx-input>
  </demo>

  <demo header="Read only">
    <fnx-check [readonly]="true"></fnx-check>
  </demo>

  <demo header="Disabled">
    <fnx-check [disabled]="true"></fnx-check>
  </demo>
  ''',
)
class CheckExample {}
