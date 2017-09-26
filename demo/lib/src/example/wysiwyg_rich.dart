import 'package:angular2/core.dart';

@Component(
  selector: 'wysiwyg-rich-example',
  template: '''
  <documentation [componentTag]="'fnx-wysiwyg-rich'"></documentation>

  <h2>Demo</h2>

  <demo header="Standalone">
    <fnx-wysiwyg-rich></fnx-wysiwyg-rich>
  </demo>
  ''',
)
class WysiwygRichExample {}
