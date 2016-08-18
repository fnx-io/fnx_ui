// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/components/modal/fnx_modal.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import 'example_buttons_renderer.dart';

@Component(
    selector: 'example-modals',
    templateUrl: 'example_modals.html',
    directives: const [ExampleButtonsRenderer]
)
class ExampleModals {

  FnxApp app;

  final Logger log = new Logger("ExampleModals");

  bool customModalVisible = false;

  ExampleModals(this.app);

  void openAlert() {
    app.alert(
        "Lorem ipsum dolor sit modal, eos error eveniet fuga iste mollitia nisi, omnis porro provident quia tempore.",
        headline: "Lorem headline"

    ).then( (_) => showToast("Closed!", 1000) );
  }

  void openConfirm() {
    app.confirm(
        "Lorem ipsum dolor sit confirm, eos error eveniet fuga iste mollitia nisi, omnis porro provident quia tempore.",
        headline: "Confirm please"

    ).then( (_) => showToast("Closed with ${_}", 2000) );
  }

  void openInput() {
    app.input(
        "Input value between 2 and 4, but not 3",
        headline: "Lorem ipsum dolor sit input"

    ).then( (val) => showToast("Value = ${val}", 2000) );
  }

  void showToast(String text, int duration) {
    app.toast(text, duration: new Duration(milliseconds: duration));
  }

}