// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';

import 'app_config.dart';

@Component(
  selector: 'example-form',
  templateUrl: 'example_form.html',
  directives: [
    fnxUiDirectives,
    coreDirectives,
    formDirectives,
    appDirectives
  ],
)
class ExampleForm {

  Map record = { };

  FnxApp app;

  bool readonly = false;
  bool disabled = false;

  ExampleForm(this.app);

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
