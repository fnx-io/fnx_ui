import 'package:angular_router/angular_router.dart';
import 'package:fnx_ui_showcase/components/about.template.dart';
import 'package:fnx_ui_showcase/components/example_testing.template.dart';
import 'package:fnx_ui_showcase/components/example_modals.template.dart';
import 'package:fnx_ui_showcase/components/cookbook/cookbook_select_or_create.template.dart';
import 'package:fnx_ui_showcase/components/cookbook/cookbook_dynarows.template.dart';
import 'package:fnx_ui_showcase/example_app.template.dart';
import 'package:fnx_ui_showcase/components/cookbook/cookbook_tags.template.dart';
import 'package:fnx_ui_showcase/components/cookbook/cookbook_master_detail.template.dart';
import 'package:fnx_ui_showcase/components/example_testing.template.dart';
import 'package:fnx_ui_showcase/components/cookbook/cookbook_3step.template.dart';
import 'package:fnx_ui_showcase/components/cookbook/cookbook_preloader.template.dart';
import 'package:fnx_ui_showcase/components/cookbook/cookbook_crop.template.dart';
import 'package:fnx_ui_showcase/components/example_form.template.dart';
import 'package:fnx_ui_showcase/components/example_tabs.template.dart';
import 'package:fnx_ui_showcase/components/example_tooltip.template.dart';
import 'package:fnx_ui_showcase/components/example_reorder.template.dart';
import 'package:fnx_ui_showcase/components/example_exceptions.template.dart';
import 'package:fnx_ui_showcase/components/cookbook/cookbook_form_validation.template.dart';
import 'package:fnx_ui_showcase/components/example_panels.template.dart';
import 'package:fnx_ui_showcase/components/cookbook/cookbook_table.template.dart';
import 'package:fnx_ui_showcase/components/cookbook/cookbook_dashboard.template.dart';
import 'package:fnx_ui_showcase/components/cookbook/cookbook_wizard.template.dart';
import 'package:fnx_ui_showcase/components/example_buttons_renderer.template.dart';

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

  RoutePath testing = new RoutePath(path: "testing", parent: null);
  RoutePath about = new RoutePath(path: "about");
  RoutePath modals = new RoutePath(path: "modals", parent:null);
  RoutePath cookbookwizard = new RoutePath(path: "cookbookwizard", parent:null);
  RoutePath cookbookdynarows = new RoutePath(path: "cookbookdynarows", parent:null);
  RoutePath cookbookformvalidation = new RoutePath(path: "cookbookformvalidation", parent:null);
  RoutePath cookbookmasterdetail = new RoutePath(path: "cookbookmasterdetail", parent:null);
  RoutePath cookbooktags = new RoutePath(path: "cookbooktags", parent:null);
  RoutePath cookbookpreloader = new RoutePath(path: "cookbookpreloader", parent:null);
  RoutePath cookbookdashboard = new RoutePath(path: "cookbookdashboard", parent:null);
  RoutePath cookbook3step = new RoutePath(path: "cookbook3step", parent:null);
  RoutePath cookbookselectorcreate = new RoutePath(path: "cookbookselectorcreate", parent:null);
  RoutePath cookbooktable = new RoutePath(path: "cookbooktable", parent:null);
  RoutePath cookbookcrop = new RoutePath(path: "cookbookcrop", parent:null);
  RoutePath panels = new RoutePath(path: "panels", parent:null);
  RoutePath tabs = new RoutePath(path: "tabs", parent:null);
  RoutePath tooltip = new RoutePath(path: "tooltip", parent:null);
  RoutePath exceptions = new RoutePath(path: "exceptions", parent:null);
  RoutePath reorder = new RoutePath(path: "reorder", parent:null);
  RoutePath form = new RoutePath(path: "form", parent:null);  
  
  List<RouteDefinition> routes = [];

  Routing() {
    routes.add(new RouteDefinition(routePath: about, component: AboutNgFactory, useAsDefault: true));
    routes.add(new RouteDefinition(routePath: testing, component: ExampleTestingNgFactory));
    routes.add(new RouteDefinition(routePath: modals, component: ExampleModalsNgFactory));
    routes.add(new RouteDefinition(routePath: cookbookwizard, component: CookbookWizardNgFactory));
    routes.add(new RouteDefinition(routePath: cookbookdynarows, component: CookbookDynarowsNgFactory));
    routes.add(new RouteDefinition(routePath: cookbookformvalidation, component: CookbookFormValidationNgFactory));
    routes.add(new RouteDefinition(routePath: cookbookmasterdetail, component: CookbookMasterDetailNgFactory));
    routes.add(new RouteDefinition(routePath: cookbooktags, component: CookbookTagsNgFactory));
    routes.add(new RouteDefinition(routePath: cookbookpreloader, component: CookbookPreloaderNgFactory));
    routes.add(new RouteDefinition(routePath: cookbookdashboard, component: CookbookDashboardNgFactory));
    routes.add(new RouteDefinition(routePath: cookbook3step, component: Cookbook3StepNgFactory));
    routes.add(new RouteDefinition(routePath: cookbookselectorcreate, component: CookbookSelectOrCreateNgFactory));
    routes.add(new RouteDefinition(routePath: cookbooktable, component: CookbookTableNgFactory));
    routes.add(new RouteDefinition(routePath: cookbookcrop, component: CookbookCropNgFactory));
    routes.add(new RouteDefinition(routePath: panels, component: ExamplePanelsNgFactory));
    routes.add(new RouteDefinition(routePath: tabs, component: ExampleTabsNgFactory));
    routes.add(new RouteDefinition(routePath: tooltip, component: ExampleTooltipNgFactory));
    routes.add(new RouteDefinition(routePath: exceptions, component: ExampleExceptionsNgFactory));
    routes.add(new RouteDefinition(routePath: reorder, component: ExampleReorderNgFactory));
    routes.add(new RouteDefinition(routePath: form, component: ExampleFormNgFactory));
  }
}

Routing routingFactory() {
  print("dsadsadsada");
  return new Routing();
}