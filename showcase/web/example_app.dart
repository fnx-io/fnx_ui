// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'cookbook/cookbook_form_validation.dart';
import 'dart:math';

import 'example_reorder.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'about.dart';
import 'cookbook/cookbook_3step.dart';
import 'cookbook/cookbook_crop.dart';
import 'cookbook/cookbook_dashboard.dart';
import 'cookbook/cookbook_dynarows.dart';
import 'cookbook/cookbook_master_detail.dart';
import 'cookbook/cookbook_preloader.dart';
import 'cookbook/cookbook_select_or_create.dart';
import 'cookbook/cookbook_table.dart';
import 'cookbook/cookbook_tags.dart';
import 'cookbook/cookbook_wizard.dart';
import 'example_buttons_renderer.dart';
import 'example_exceptions.dart';
import 'example_form.dart';
import 'example_modals.dart';
import 'example_panels.dart';
import 'example_tabs.dart';
import 'example_testing.dart';

@Component(
    selector: 'example-app',
    templateUrl: 'example_app.html',
    directives: const [ExampleButtonsRenderer]
)
@RouteConfig(const [
  const Route(path: "/Testing", name: "Testing", component: ExampleTesting),

  const Route(path: "/Form", name: "Form", component: ExampleForm),
  const Route(path: "/About", name: "About", component: About, useAsDefault: true),
  const Route(path: "/Panels", name: "Panels", component: ExamplePanels),
  const Route(path: "/Modals", name: "Modals", component: ExampleModals),
  const Route(path: "/Reorder", name: "Reorder", component: ExampleReorder),
  const Route(path: "/Exceptions", name: "Exceptions", component: ExampleExceptions),
  const Route(path: "/Tabs/...", name: "Tabs", component: ExampleTabs),

  const Route(path: "/Cookbook/Crop", name: "Cookbook-Crop", component: CookbookCrop),
  const Route(path: "/Cookbook/Preloader", name: "Cookbook-Preloader", component: CookbookPreloader),
  const Route(path: "/Cookbook/Table", name: "Cookbook-Table", component: CookbookTable),
  const Route(path: "/Cookbook/Dashboard", name: "Cookbook-Dashboard", component: CookbookDashboard),
  const Route(path: "/Cookbook/3step", name: "Cookbook-3step", component: Cookbook3Step),
  const Route(path: "/Cookbook/Dynarows", name: "Cookbook-Dynarows", component: CookbookDynarows),
  const Route(path: "/Cookbook/MasterDetail", name: "Cookbook-MasterDetail", component: CookbookMasterDetail),
  const Route(path: "/Cookbook/Tags", name: "Cookbook-Tags", component: CookbookTags),
  const Route(path: "/Cookbook/SelectOrCreate", name: "Cookbook-SelectOrCreate", component: CookbookSelectOrCreate),
  const Route(path: "/Cookbook/Wizard", name: "Cookbook-Wizard", component: CookbookWizard),
  const Route(path: "/Cookbook/FormValidation", name: "Cookbook-FormValidation", component: CookbookFormValidation)
])
class ExampleApp {

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
