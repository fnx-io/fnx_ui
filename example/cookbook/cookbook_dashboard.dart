// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import '../example_app.dart';
import 'dart:math';
import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/components/modal/fnx_modal.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import '../example_buttons_renderer.dart';

@Component(
    selector: 'cookbook-dashboard',
    templateUrl: 'cookbook_dashboard.html',
    directives: const [ExampleButtonsRenderer]
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