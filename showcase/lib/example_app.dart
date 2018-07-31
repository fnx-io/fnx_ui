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
  visibility: Visibility.all
)
class ExampleApp {

  Routing routing;

  Random r = new Random();

  List<Map<String,Object>> list = [];
  
  ExampleApp(this.routing);

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
