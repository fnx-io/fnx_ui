import 'package:angular2/core.dart';

import 'package:fnx_ui_demo/src/model/showcase.dart';

@Component(
  selector: 'default-showcase',
  template: '''
  <div class="row--gutter">
    <template ngFor [ngForOf]="showcases" let-showcase>
      <a *ngIf="showcase?.link != null"
         class="l3 m4 s12 bg--white pointer card shadow--raising"
         [routerLink]="showcase?.link">
        <div class="padding">
          <h4>{{showcase?.name}} <span class='mi'>arrow_forward</span></h4>
          <p>{{showcase?.description}}</p>
        </div>
      </a>
    </template>
  </div>
  ''',
)
class DefaultShowcase {

  List<Showcase> showcases = [
    const Showcase(name: 'colors', link: const ['Colors'], description: 'Alfa beta gama'),
    const Showcase(name: 'flex', link: const ['Flex'], description: 'Alfa beta gama'),
    const Showcase(name: 'grid', link: const ['Grid'], description: 'Alfa beta gama'),
    const Showcase(name: 'icons', link: const ['Icons'], description: 'Alfa beta gama'),
    const Showcase(name: 'shadows', link: const ['Shadows'], description: 'Alfa beta gama'),
    const Showcase(name: 'typography', link: const ['Typography'], description: 'Alfa beta gama'),
    const Showcase(name: 'utilities', link: const ['Utilities'], description: 'Alfa beta gama'),
  ];
}
