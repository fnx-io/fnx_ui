// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular2/core.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';

import 'example_buttons_renderer.dart';

@Component(
    selector: 'example-form',
    templateUrl: 'example_form.html',
    directives: const [ExampleButtonsRenderer]
)
class ExampleForm {

  Map record = { };

  FnxApp app;

  bool readonly = false;

  ExampleForm(this.app) {
    for (int a=0;a<1000;a++) {
      mnogo.add("$a dasdsdsd dsadas");
    }
  }

  List<String> mnogo = [];

  void postRecord() {
    app.toast("And I'm posting your data right now: ${record}", duration: new Duration(milliseconds: 3000));
  }

  void uploadFile(File data) {
    if (data == null) {
      app.toast("Deleted");
      record['photo'] = null;
    } else {
      app.toast("Uloading ${data.name}");
      record['photo'] = "//example.com/${data.name}";
    }
  }
}
