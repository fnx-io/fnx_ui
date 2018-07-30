// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import 'package:fnx_ui_showcase/app_config.dart';

@Component(
  selector: 'cookbook-dashboard',
  templateUrl: 'cookbook_dashboard.html',
  directives: [
    fnxUiDirectives,
    coreDirectives,
    formDirectives,
    appDirectives
  ],
)
class CookbookDashboard {

  FnxApp app;

  List<DemoTile> tiles = [];

  CookbookDashboard(this.app) {
    tiles.add(new DemoTile("Some action", "accessible", "bg--fnx"));
    tiles.add(new DemoTile("Other action", "warning", "bg--white"));
    tiles.add(new DemoTile("No action", "android", "bg--white"));
    tiles.add(new DemoTile("Bad action", "build", "bg--fnx"));
    tiles.add(new DemoTile("Good action", "backup", "bg--fnx"));
    tiles.add(new DemoTile("The best action", "extension", "bg--fnx"));
    tiles.add(new DemoTile("Unknown action", "face", "bg--fnx"));
    tiles.add(new DemoTile("Active action", "grade", "bg--white"));
    tiles.add(new DemoTile("Pasive action", "language", "bg--white"));
    tiles.add(new DemoTile("The worst action", "lock", "bg--yellow"));
    tiles.add(new DemoTile("Frequent action", "loop", "bg--white"));
    tiles.add(new DemoTile("Rare action", "web", "bg--white"));
    tiles.add(new DemoTile("Hidden action", "call", "bg--white"));
    tiles.add(new DemoTile("Stupid action", "save", "bg--yellow"));
    tiles.add(new DemoTile("Smart action", "cloud", "bg--white"));
    tiles.add(new DemoTile("Example action", "watch", "bg--yellow"));
    tiles.add(new DemoTile("Quick action", "lens", "bg--white"));
    tiles.add(new DemoTile("Slow action", "navigation", "bg--yellow"));

    tiles.shuffle();
  }

  void doExampleFeedback(DemoTile t) {
    app.toast("You clicked on '${t.text}'! Great!");
  }

}

class DemoTile {

  static Random rnd = new Random();

  String text;
  String icon;
  String color;
  int count = 0;

  DemoTile(this.text, this.icon, this.color) {
    if (rnd.nextDouble() > 0.7) {
      count = rnd.nextInt(20);
    }
  }

}