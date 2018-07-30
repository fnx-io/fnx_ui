// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui_showcase/app_config.dart';
import 'package:logging/logging.dart';
import 'package:fnx_ui_showcase/components/example_tabs.template.dart';

@Component(
  selector: 'example-tabs',
  templateUrl: 'example_tabs.html',
  directives: [
    fnxUiDirectives,
    coreDirectives,
    formDirectives,
    appDirectives,
    routerDirectives,
  ],
)
/*
@RouteConfig(const [
  const Route(path: "/Tab1", name: "Tab1", component: ExampleTabs1, useAsDefault: true),
  const Route(path: "/Tab2", name: "Tab2", component: ExampleTabs2),
  const Route(path: "/Tab3", name: "Tab3", component: ExampleTabs3),
  const Route(path: "/Tab4", name: "Tab4", component: ExampleTabs4),
  const Route(path: "/Tab5", name: "Tab5", component: ExampleTabs5)
])
*/
class ExampleTabs {

  final Logger log = new Logger("ExampleTabs");

  RoutePath tabs1 = new RoutePath(path: "tabs1", parent:null);
  RoutePath tabs2 = new RoutePath(path: "tabs2", parent:null);
  RoutePath tabs3 = new RoutePath(path: "tabs3", parent:null);
  RoutePath tabs4 = new RoutePath(path: "tabs4", parent:null);
  RoutePath tabs5 = new RoutePath(path: "tabs5", parent:null);

  List<RouteDefinition> routes;

  ExampleTabs() {
    routes = [];
    routes.add(new RouteDefinition(routePath: tabs1, component: ExampleTabs1NgFactory));
    routes.add(new RouteDefinition(routePath: tabs2, component: ExampleTabs2NgFactory));
    routes.add(new RouteDefinition(routePath: tabs3, component: ExampleTabs3NgFactory));
    routes.add(new RouteDefinition(routePath: tabs4, component: ExampleTabs4NgFactory));
    routes.add(new RouteDefinition(routePath: tabs5, component: ExampleTabs5NgFactory));
  }

  void debug(String name) {
    print(name);
  }

}

@Component(
    selector: 'example-tabs-1',
    template: "<p>Hi, I'm tab 1</p>"
)
class ExampleTabs1 {

}
@Component(
    selector: 'example-tabs-2',
    template: "<p>Go away, I'm tab 2</p>"
)
class ExampleTabs2 {

}
@Component(
    selector: 'example-tabs-3',
    template: "<p>Come back, I'm tab 3!</p>"
)
class ExampleTabs3 {

}
@Component(
    selector: 'example-tabs-4',
    template: "<p>Quatro!</p>"
)
class ExampleTabs4 {

}
@Component(
    selector: 'example-tabs-5',
    template: "<p>Pět</p>"
)
class ExampleTabs5 {

}

