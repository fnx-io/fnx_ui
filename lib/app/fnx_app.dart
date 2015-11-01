@HtmlImport("fnx_app.html")
library fnx_ui.fnx_app;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/paper_ripple.dart';
import 'package:polymer_elements/paper_progress.dart';

import '../fnx_ui.dart';
import 'package:logging/logging.dart';

part 'fnx_app_aware_behavior.dart';

FnxApp fnxAppInstance = null;

@PolymerRegister("fnx-app")
class FnxApp extends PolymerElement with FnxEventBehavior {

  Logger _log = new Logger("fnx");

  int _workingCounter = 0;

  @property
  bool working = false;

  FnxApp.created() : super.created() {
    if (fnxAppInstance != null) {
      throw "Only one fnx-app is alowed in the app";
    }
    fnxAppInstance = this;
  }

  void workStarted() {
    _workingCounter++;
    if (_workingCounter > 0) {
      set("working", true);
    }
  }

  void workFinished() {
    _workingCounter--;
    if (_workingCounter == 0) {
      set("working", false);
    }
    assert(()=>_workingCounter >= 0);
  }

}