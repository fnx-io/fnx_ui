import 'package:angular2/core.dart';

import 'package:fnx_ui_demo/src/model/showcase.dart';

@Component(
  selector: 'preloader-showcase',
  template: '''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>

  <div class="text--center padding--big text--fnx margin--big--top">
    <h1 class="margin--big--bottom">fnx|ui example set</h1>
    <span class="preloader bg--white fs-xxl margin--big--bottom"></span>
    <p>... is loading</p>
  </div>
  ''',
)
class PreloaderShowcase {}
