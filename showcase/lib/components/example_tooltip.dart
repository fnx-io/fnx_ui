// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui_showcase/app_config.dart';
import 'package:logging/logging.dart';

@Component(
  selector: 'example-tooltip',
  templateUrl: 'example_tooltip.html',
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
class ExampleTooltip {

  final Logger log = new Logger("ExampleTooltip");


  ExampleTooltip();

  String tooltipProvider() {
    return "This is functional tooltip!";
  }

  Function tooltipClosure(int data) {
    return () {
      return "Dynamic tooltip from closure $data";
    };
  }

  Future delayedTooltip([int data = 0]) async {
    await new Future.delayed(new Duration(milliseconds: 1000));
    return "And here it comes = $data!";
  }

  Function delayedClosure(int data) {
    return () {
      return delayedTooltip(data);
    };
  }

  String htmlTooltip = """
    <h4>Yes, it's possible</h4>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium, consequuntur doloremque
     in incidunt nostrum quis reiciendis tempore voluptates? A aut beatae blanditiis debitis excepturi
      exercitationem incidunt modi obcaecati possimus ut!</p>
    <p class='text--red'>Or is it? Yes it is.</p>
  """;

}

