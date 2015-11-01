@HtmlImport("fnx_field.html")
library fnx_ui.fnx_field;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/paper_ripple.dart';
import 'package:polymer_elements/paper_material.dart';

import '../fnx_ui.dart';

@PolymerRegister("fnx-field")
class FnxField extends PolymerElement {

  @property
  String label = null;

  @Property(computed: 'computeHasValue(label)')
  bool hasLabel = false;

  @property
  String help = null;

  @Property(computed: 'computeHasValue(help)')
  bool hasHelp = false;

  @property
  String error = null;

  @Property(computed: 'computeHasValue(error)')
  bool hasError = false;

  @Listen("error-changed")
  void printNasrat() {
    print("nasrat $error");
  }

  @reflectable
  bool computeHasValue(String e) {
    return e != null;
  }

  @Listen("focusin")
  void listenFocusIn(_, __) {
    classes.add("focused");
  }

  @Listen("focusout")
  void listenFocusOut(_, __) {
    classes.remove("focused");
  }


  FnxField.created() : super.created();

}
