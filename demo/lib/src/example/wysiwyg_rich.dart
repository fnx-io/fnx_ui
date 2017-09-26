import 'package:angular2/core.dart';

@Component(
  selector: 'wysiwyg-rich-example',
  template: '''
  <documentation [componentTag]="'fnx-wysiwyg-rich'"></documentation>

  <h1>Demo</h1>

  <demo label="Standalone">
    <fnx-wysiwyg-rich></fnx-wysiwyg-rich>
  </demo>
  ''',
)
class WysiwygRichExample {}
