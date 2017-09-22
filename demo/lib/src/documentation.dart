import 'package:angular2/core.dart';

import 'package:fnx_ui_demo/data.dart';

@Component(
  selector: 'documentation',
  templateUrl: 'documentation.html',
)
class Documentation implements OnInit {
  @Input()
  String componentTag;

  ComponentModel component;

  String get componentPreview {
    StringBuffer sb = new StringBuffer();

    sb.write('<${component?.tag}');

    if (component?.ngModelCompatible == true) {
      sb.write(' [(ngModel)]="..."');
    }

    component?.ios?.where((IoModel io) => io.isInput && io.isOutput)?.forEach((IoModel input) {
      sb.write(' [(${input?.name})]="..."');
    });

    component?.ios?.where((IoModel io) => io.isInput && !io.isOutput)?.forEach((IoModel input) {
      sb.write(' [${input?.name}]="..."');
    });

    component?.ios?.where((IoModel io) => !io.isInput && io.isOutput)?.forEach((IoModel output) {
      sb.write(' (${output?.name})="..."');
    });

    sb.write('></${component?.tag}>');

    return sb.toString();
  }

  @override
  ngOnInit() {
    component =
        componentsData?.firstWhere((ComponentModel component) => component.tag == componentTag, orElse: ([_]) => null);
  }
}
