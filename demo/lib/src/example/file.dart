import 'package:angular2/core.dart';

@Component(
  selector: 'file-example',
  template: '''
  <documentation [componentTag]="'fnx-file'"></documentation>

  <h1>Demo</h1>

  <demo label="Standalone">
    <fnx-file></fnx-file>
  </demo>

  <demo label="Required">
    <fnx-input>
      <fnx-file [required]="true"></fnx-file>
    </fnx-input>
  </demo>

  <demo label="Read only">
    <fnx-input>
      <fnx-file [readonly]="true"></fnx-file>
    </fnx-input>
  </demo>

  <demo label="Browse label">
    <fnx-input>
      <fnx-file browseLabel="Browse label"></fnx-file>
    </fnx-input>
  </demo>
  ''',
)
class FileExample {}
