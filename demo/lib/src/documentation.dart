import 'package:angular2/core.dart';

import 'package:fnx_ui_demo/data.dart';

@Component(
  selector: 'documentation',
  templateUrl: 'documentation.html',
  styles: const ['''
  :host .link {
      border-bottom: 1px dotted #777;
  }
  '''],
)
class Documentation implements OnInit {
  @Input()
  String componentTag;

  ComponentModel component;
  
  final String dartDocLink = 'http://demo.fnx.io/fnx_ui/doc/fnx_ui';

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

  List<IoModel> get componentInputs {
    return component?.ios?.where((IoModel io) => io?.isInput == true)?.toList() ?? [];
  }

  List<IoModel> get componentOutputs {
    return component?.ios?.where((IoModel io) => io?.isOutput == true)?.toList() ?? [];
  }
}
