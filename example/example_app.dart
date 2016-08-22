// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:angular2/router.dart';
import 'package:fnx_ui/src/components/modal/fnx_modal.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import 'example_testing.dart';
import 'example_panels.dart';
import 'example_buttons_renderer.dart';
import 'example_modals.dart';
import 'dart:math';
import 'example_tabs.dart';

@Component(
    selector: 'example-app',
    templateUrl: 'example_app.html',
    directives: const [ExampleButtonsRenderer]
)
@RouteConfig(const [
  const Route(path: "/Testing", name: "Testing", component: ExampleTesting, useAsDefault: true),
  const Route(path: "/Panels", name: "Panels", component: ExamplePanels),
  const Route(path: "/Modals", name: "Modals", component: ExampleModals),
  const Route(path: "/Tabs/...", name: "Tabs", component: ExampleTabs)
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
    "D"
  ];


  void loadMore() {
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
