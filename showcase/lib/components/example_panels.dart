// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:logging/logging.dart';

import 'app_config.dart';
import 'example_app.dart';

@Component(
  selector: 'example-panels',
  templateUrl: 'example_panels.html',
  directives: [
    fnxUiDirectives,
    coreDirectives,
    formDirectives,
    appDirectives
  ],
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
