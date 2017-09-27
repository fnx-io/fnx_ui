import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:fnx_ui_demo/src/showcase/colors.dart';
import 'package:fnx_ui_demo/src/showcase/default.dart';
import 'package:fnx_ui_demo/src/showcase/flex.dart';
import 'package:fnx_ui_demo/src/showcase/grid.dart';
import 'package:fnx_ui_demo/src/showcase/icons.dart';
import 'package:fnx_ui_demo/src/showcase/shadows.dart';
import 'package:fnx_ui_demo/src/showcase/typography.dart';
import 'package:fnx_ui_demo/src/showcase/utilities.dart';

@Component(
  selector: 'documentation-screen',
  template: '''<router-outlet></router-outlet>''',
)
@RouteConfig(const [
  const Route(path: '/', name: 'Default', component: DefaultShowcase, useAsDefault: true),
  const Route(path: '/colors', name: 'Colors', component: ColorsShowcase),
  const Route(path: '/flex', name: 'Flex', component: FlexShowcase),
  const Route(path: '/grid', name: 'Grid', component: GridShowcase),
  const Route(path: '/icons', name: 'Icons', component: IconsShowcase),
  const Route(path: '/shadows', name: 'Shadows', component: ShadowsShowcase),
  const Route(path: '/typography', name: 'Typography', component: TypographyShowcase),
  const Route(path: '/utilities', name: 'Utilities', component: UtilitiesShowcase),
])
class DocumentationScreen {}
