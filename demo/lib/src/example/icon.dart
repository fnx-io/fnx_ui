import 'package:angular2/core.dart';

@Component(
  selector: 'icon-example',
  template: '''
  <documentation [componentTag]="'fnx-icon'"></documentation>

  <demo label="Standalone">
    <fnx-icon type="code"></fnx-icon>
  </demo>

  <demo label="Multiple icons">
    <fnx-icon type="code"></fnx-icon>
    <fnx-icon type="build"></fnx-icon>
    <fnx-icon type="book"></fnx-icon>
    <fnx-icon type="done"></fnx-icon>
    <fnx-icon type="delete"></fnx-icon>
  </demo>
  ''',
)
class IconExample {}
