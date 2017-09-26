import 'package:angular2/core.dart';

@Component(
  selector: 'demo',
  templateUrl: 'demo.html',
)
class Demo {
  @Input()
  String header;
}
