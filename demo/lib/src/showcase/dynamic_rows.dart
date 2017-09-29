import 'package:angular2/core.dart';

import 'package:fnx_ui_demo/src/model/showcase.dart';

@Component(
  selector: 'dynamic-rows-showcase',
  template: '''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>

  ''',
)
class DynamicRowsShowcase {}
