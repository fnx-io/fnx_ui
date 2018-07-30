// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui_showcase/app_config.dart';
import 'package:fnx_ui_showcase/routing.dart';

@Component(
  selector: 'example-app',
  templateUrl: 'example_app.html',
  directives: [
    fnxUiDirectives,
    coreDirectives,
    routerDirectives,
    formDirectives,
    appDirectives
  ],
)
class ExampleApp {

  Routing routing = new Routing();

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

  Random r = new Random();

  List<Map<String,Object>> list = [];

  List<String> names = [
    "Alice",
    "Chains",
    "Pink",
    "Floyd",
    "Jethro",
    "Tull",
    "Led",
    "Zeppelin",
    "Iron",
    "Maiden",
    "Velvet",
    "Underground",
    "Tenacious",
    "D",
    "Jefferson",
    "Airplane",
    "Rolling",
    "Stones",
    "Grateful",
    "Dead"
  ];


  void loadMore() {
    if (list.length >= 500) return;

    for (int a=0;a<10;a++) {
      Map<String, Object> row = {};
      String n1 = names[r.nextInt(names.length)];
      String n2 = names[r.nextInt(names.length)];
      String n3 = names[r.nextInt(names.length)];

      row["id"] = list.length + 1;
      row["name"] = "$n1 $n2";
      row["email"] = "$n1.$n2@$n3.com".toLowerCase();

      list.add(row);
    }
  }


}
