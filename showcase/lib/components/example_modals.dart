// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import 'package:logging/logging.dart';

import 'app_config.dart';

@Component(
  selector: 'example-modals',
  templateUrl: 'example_modals.html',
  directives: [
    fnxUiDirectives,
    coreDirectives,
    formDirectives,
    appDirectives
  ],
)
class ExampleModals {
  FnxApp app;

  final Logger log = new Logger("ExampleModals");

  bool customModalVisible = false;

  List<String> selectData = [];

  ExampleModals(this.app);

  Future<Null> openAlert() async {
    await app.alert(
        "Lorem ipsum dolor sit modal, eos error eveniet fuga iste mollitia nisi, omnis porro provident quia tempore.",
        headline: "Lorem headline");
    showToast("Closed!", 1000);
  }

  Future<Null> openConfirm() async {
    bool result = await app.confirm(
        "Lorem ipsum dolor sit confirm, eos error eveniet fuga iste mollitia nisi, omnis porro provident quia tempore.",
        headline: "Confirm please");
    showToast("Closed with ${result}", 2000);
  }

  Future<Null> openInput() async {
    var val = await app.input(
        "Input value between 2 and 4, but not 3",
        headline: "Lorem ipsum dolor sit input",
        prefilledValue: "3");
    showToast("Value = ${val}", 2000);
  }

  void showToast(String text, int duration) {
    app.toast(text, duration: new Duration(milliseconds: duration));
  }

}