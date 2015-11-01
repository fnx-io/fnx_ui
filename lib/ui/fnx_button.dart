@HtmlImport("fnx_button.html")
library fnx_ui.fnx_button;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/paper_ripple.dart';
import 'package:polymer_elements/paper_material.dart';

import '../fnx_ui.dart';

@PolymerRegister("fnx-button")
class FnxButton extends PolymerElement with FnxEventBehavior {

  @property
  bool primary = false;

  @property
  bool secondary = false;

  @property
  bool negative = false;

  FnxButton.created() : super.created();

}
