// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:fnx_ui_documentation/about/module_about.dart';
import 'about/module_about.dart';
import 'getting_started/module_getting_started.dart';
import 'layout/module_layout.dart';
import 'application/module_application.dart';
import 'forms/module_forms.dart';
import 'other_components/module_other_components.dart';

@Component(
    selector: 'main-app',
    templateUrl: 'main_app.html'
)
@RouteConfig(const [
  const Route(path: "/About/...", name: "About", component: ModuleAbout, useAsDefault: true),
  const Route(path: "/GettingStarted/...", name: "GettingStarted", component: ModuleGettingStarted),
  const Route(path: "/Layout/...", name: "Layout", component: ModuleLayout),
  const Route(path: "/Application/...", name: "Application", component: ModuleApplication),
  const Route(path: "/Forms/...", name: "Forms", component: ModuleForms),
  const Route(path: "/OtherComponents/...", name: "OtherComponents", component: ModuleOtherComponents),
])
class MainApp {

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
