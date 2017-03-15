// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';

import 'example_app.dart';
import 'example_buttons_renderer.dart';

@Component(
    selector: 'example-panels',
    templateUrl: 'example_panels.html',
    directives: const [ExampleButtonsRenderer]
)
class ExamplePanels implements OnInit {

  final Logger log = new Logger("ExamplePanels");

  ExampleApp app;

  ExamplePanels(this.app);

  ngOnInit() {
    loadMore();
  }

  List get list => app.list;

  void loadMore() {
    app.loadMore();
  }

}
