// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:fnx_ui_showcase/app_config.dart';

@Component(
  selector: 'cookbook-wizard',
  templateUrl: 'cookbook_wizard.html',
  directives: [
    fnxUiDirectives,
    coreDirectives,
    formDirectives,
    appDirectives
  ],
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
