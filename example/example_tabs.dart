// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/components/modal/fnx_modal.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import 'example_buttons_renderer.dart';
import 'example_app.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'example-tabs',
    templateUrl: 'example_tabs.html',
    directives: const [ExampleButtonsRenderer]
)
@RouteConfig(const [
  const Route(path: "/Tab1", name: "Tab1", component: ExampleTabs1, useAsDefault: true),
  const Route(path: "/Tab2", name: "Tab2", component: ExampleTabs2),
  const Route(path: "/Tab3", name: "Tab3", component: ExampleTabs3),
  const Route(path: "/Tab4", name: "Tab4", component: ExampleTabs4),
  const Route(path: "/Tab5", name: "Tab5", component: ExampleTabs5)
])
class ExampleTabs {

  final Logger log = new Logger("ExampleTabs");

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

