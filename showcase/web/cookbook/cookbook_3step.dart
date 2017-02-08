// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import '../example_app.dart';
import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/components/modal/fnx_modal.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import '../example_buttons_renderer.dart';

@Component(
    selector: 'cookbook-3step',
    templateUrl: 'cookbook_3step.html',
    directives: const [ExampleButtonsRenderer]
)
class Cookbook3Step {

  FnxApp app;

  Cookbook3Step(this.app);

  String selected1 = null;
  String selected2 = null;

  List<String> step1 = ["A", "B", "C", "D", "E"];
  List<String> step2 = [];
  List<String> step3 = [];

  void loadStep2(String item) {
    selected1 = item;
    step2 = [];
    for (int a=1;a<8;a++) {
      step2.add("$item.$a");
    }
  }

  void loadStep3(String item) {
    selected2 = item;
    step3 = [];
    for (int a=1;a<12;a++) {
      step3.add("$item - $a");
    }
  }

  void finish(String item) {
    app.confirm("Please confirm that '$item' is the right value").then((bool result) { if (result) app.toast("Great!"); });
  }

}
