import 'package:angular2/core.dart';

@Component(
  selector: 'wysiwyg-poor-example',
  template: '''
  <documentation [componentTag]="'fnx-wysiwyg-poor'"></documentation>

  <h2>Demo</h2>

  <demo header="Standalone">
    <fnx-wysiwyg-poor></fnx-wysiwyg-poor>
  </demo>
  ''',
)
class WysiwygPoorExample {}
