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
    const Showcase(name: 'complex validation', link: const ['ComplexValidation'], description: 'Alfa beta gama'),
    const Showcase(name: 'dynamic rows', link: const ['DynamicRows'], description: 'Alfa beta gama'),
    const Showcase(name: 'flex', link: const ['Flex'], description: 'Alfa beta gama'),
    const Showcase(name: 'grid', link: const ['Grid'], description: 'Alfa beta gama'),
    const Showcase(name: 'icons', link: const ['Icons'], description: 'Alfa beta gama'),
    const Showcase(name: 'image crop', link: const ['ImageCrop'], description: 'Alfa beta gama'),
    const Showcase(name: 'lazy loading', link: const ['LazyLoading'], description: 'Alfa beta gama'),
    const Showcase(name: 'master detail', link: const ['MasterDetail'], description: 'Alfa beta gama'),
    const Showcase(name: 'preloader', link: const ['Preloader'], description: 'Alfa beta gama'),
    const Showcase(name: 'select or create', link: const ['SelectCreate'], description: 'Alfa beta gama'),
    const Showcase(name: 'shadows', link: const ['Shadows'], description: 'Alfa beta gama'),
    const Showcase(name: '3 step picker', link: const ['StepPicker'], description: 'Alfa beta gama'),
    const Showcase(name: 'tags and labels', link: const ['TagsLabels'], description: 'Alfa beta gama'),
    const Showcase(name: 'tiled dashboard', link: const ['TiledDashboard'], description: 'Alfa beta gama'),
    const Showcase(name: 'typography', link: const ['Typography'], description: 'Alfa beta gama'),
    const Showcase(name: 'utilities', link: const ['Utilities'], description: 'Alfa beta gama'),
    const Showcase(name: 'wizard', link: const ['Wizard'], description: 'Alfa beta gama'),
  ];
}
