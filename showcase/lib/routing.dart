import 'package:angular_router/angular_router.dart';
import 'package:fnx_ui_showcase/components/example_testing.template.dart' as tplTesting;

class Routing {



  /*
  final List<RouteDefinition> routes = [
    new RouteDefinition(path: "/Testing", component: ExampleTesting),
    new RouteDefinition(path: "/Form",  component: ExampleForm),
    new RouteDefinition(path: "/About",  component: About, useAsDefault: true),
    new RouteDefinition(path: "/Panels",  component: ExamplePanels),
    new RouteDefinition(path: "/Modals",  component: ExampleModals),
    new RouteDefinition(path: "/Reorder",  component: ExampleReorder),
    new RouteDefinition(path: "/Exceptions",  component: ExampleExceptions),
    new RouteDefinition(path: "/Tabs/...",  component: ExampleTabs),

    new RouteDefinition(path: "/Cookbook/Crop",  component: CookbookCrop),
    new RouteDefinition(path: "/Cookbook/Preloader",  component: CookbookPreloader),
    new RouteDefinition(path: "/Cookbook/Table",  component: CookbookTable),
    new RouteDefinition(path: "/Cookbook/Dashboard",  component: CookbookDashboard),
    new RouteDefinition(path: "/Cookbook/3step",  component: Cookbook3Step),
    new RouteDefinition(path: "/Cookbook/Dynarows",  component: CookbookDynarows),
    new RouteDefinition(path: "/Cookbook/MasterDetail",  component: CookbookMasterDetail),
    new RouteDefinition(path: "/Cookbook/Tags",  component: CookbookTags),
    new RouteDefinition(path: "/Cookbook/SelectOrCreate",  component: CookbookSelectOrCreate),
    new RouteDefinition(path: "/Cookbook/Wizard",  component: CookbookWizard),
    new RouteDefinition(path: "/Cookbook/FormValidation", component: CookbookFormValidation)
  ];
  */

  RoutePath testing = new RoutePath(path: "testing");
  List<RouteDefinition> routes = [];

  Routing() {
    routes.add(new RouteDefinition(routePath: testing, component: tplTesting.ExampleTestingNgFactory));
  }
}