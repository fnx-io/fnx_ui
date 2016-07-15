import 'package:angular2/angular2.dart';

@Component(
    selector: 'fnx-icon',
    template: r'''
<i class="icon">{{ type }}</i>
''')
class FnxIcon {

  @Input() String type;
}

const FNX_ICON_DIRECTIVES = const [FnxIcon];