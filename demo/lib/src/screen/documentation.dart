import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:fnx_ui_demo/component.dart';

@Component(
  selector: 'documentation-screen',
  template: '''<router-outlet></router-outlet>''',
)
@RouteConfig(const [
  const Route(path: '/colors', name: 'Colors', component: ColorsShowcase),
  const Route(path: '/complex-validation', name: 'ComplexValidation', component: ComplexValidationShowcase),
  const Route(path: '/', name: 'Default', component: DefaultShowcase, useAsDefault: true),
  const Route(path: '/dynamic-rows', name: 'DynamicRows', component: DynamicRowsShowcase),
  const Route(path: '/flex', name: 'Flex', component: FlexShowcase),
  const Route(path: '/grid', name: 'Grid', component: GridShowcase),
  const Route(path: '/icons', name: 'Icons', component: IconsShowcase),
  const Route(path: '/image-crop', name: 'ImageCrop', component: ImageCropShowcase),
  const Route(path: '/lazy-loading', name: 'LazyLoading', component: LazyLoadingShowcase),
  const Route(path: '/master-detail', name: 'MasterDetail', component: MasterDetailShowcase),
  const Route(path: '/preloader', name: 'Preloader', component: PreloaderShowcase),
  const Route(path: '/select-create', name: 'SelectCreate', component: SelectCreateShowcase),
  const Route(path: '/shadows', name: 'Shadows', component: ShadowsShowcase),
  const Route(path: '/step-picker', name: 'StepPicker', component: StepPickerShowcase),
  const Route(path: '/tags-label', name: 'TagsLabels', component: TagsLabelsShowcase),
  const Route(path: '/tiled-dashboard', name: 'TiledDashboard', component: TiledDashboardShowcase),
  const Route(path: '/typography', name: 'Typography', component: TypographyShowcase),
  const Route(path: '/utilities', name: 'Utilities', component: UtilitiesShowcase),
  const Route(path: '/wizard', name: 'Wizard', component: WizardShowcase),
])
class DocumentationScreen {}
