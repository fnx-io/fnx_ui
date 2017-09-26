import 'package:angular2/core.dart';

@Component(
  selector: 'file-example',
  template: '''
  <documentation [componentTag]="'fnx-file'"></documentation>

  <h2>Demo</h2>

  <demo header="Standalone">
    <fnx-file></fnx-file>
  </demo>

  <demo header="Required">
    <fnx-input>
      <fnx-file [required]="true"></fnx-file>
    </fnx-input>
  </demo>

  <demo header="Read only">
    <fnx-input>
      <fnx-file [readonly]="true"></fnx-file>
    </fnx-input>
  </demo>

  <demo header="Browse label">
    <fnx-input>
      <fnx-file browseLabel="Browse label"></fnx-file>
    </fnx-input>
  </demo>
  ''',
)
class FileExample {}
