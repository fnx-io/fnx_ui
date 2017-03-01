// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import '../example_app.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/components/modal/fnx_modal.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import '../example_buttons_renderer.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;

@Component(
    selector: 'cookbook-wizard',
    templateUrl: 'cookbook_wizard.html',
    directives: const [ExampleButtonsRenderer]
)
class CookbookWizard {

  FnxApp app;

  @ViewChild("wizardForm")
  FnxForm wizardForm;
  
  int step = 0;
  static int stepCount = 5;
  int maxStep = stepCount - 1; // cannot be static, wouldn't be accessible from component

  Map entity = {};

  CookbookWizard(this.app);

  Future<Null> nextStep() async {
    print("next");
    if (step == maxStep) {
      await app.alert("Saved, thank you!");
      entity = {};
      step = 0;
    } else {
      // becouse othewise would be all elements in the form marked as touched after first step
      // and their errors would be highlighted on UI
      wizardForm.markAsNotTouched();
      step++;
    }
  }

  void prevStep(Event event) {
    ui.killEvent(event);
    if (step > 0) {
      step--;
    }
  }

}
