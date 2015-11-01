@HtmlImport("fnx_submit_bar.html")
library fnx_ui.fnx_submit_bar;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/paper_ripple.dart';
import 'package:polymer_elements/paper_material.dart';

import '../fnx_ui.dart';

@PolymerRegister("fnx-submit-bar")
class FnxSubmitBar extends PolymerElement with FnxEventBehavior {

  FnxSubmitBar.created() : super.created();

}
