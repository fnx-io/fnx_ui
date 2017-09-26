import 'package:angular2/core.dart';

@Component(
  selector: 'wysiwyg-poor-example',
  template: '''
  <documentation [componentTag]="'fnx-wysiwyg-poor'"></documentation>

  <h1>Demo</h1>

  <demo label="Standalone">
    <fnx-wysiwyg-poor></fnx-wysiwyg-poor>
  </demo>
  ''',
)
class WysiwygPoorExample {}
