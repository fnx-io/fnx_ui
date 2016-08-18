// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/components/modal/fnx_modal.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import 'example_buttons_renderer.dart';

@Component(
    selector: 'example-panels',
    templateUrl: 'example_panels.html',
    directives: const [ExampleButtonsRenderer]
)
class ExamplePanels implements OnInit {

  final Logger log = new Logger("ExamplePanels");

  List<Map> tableData = [];

  ngOnInit() {
    loadMore();
  }

  void loadMore() {
    for (int a=0;a<10;a++) {
      Map<String, Object> row = {};
      row["id"] = tableData.length + 1;
      tableData.add(row);
    }
  }
}
