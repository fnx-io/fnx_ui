import 'package:angular2/core.dart';

@Component(
  selector: 'shadows-showcase',
  template: '''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>
  
  shadows
  ''',
)
class ShadowsShowcase {}
