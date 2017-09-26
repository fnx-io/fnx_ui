import 'package:angular2/core.dart';

@Component(
  selector: 'demo',
  styles: const [
    '''
  :host {
    display: block;
    margin-top: 15px;
    margin-bottom: 50px;
  }
  '''
  ],
  templateUrl: 'demo.html',
)
class Demo {
  @Input()
  String label;
}
