@HtmlImport("fnx_fieldset.html")
library fnx_ui.fnx_fieldset;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/paper_ripple.dart';
import 'package:polymer_elements/paper_material.dart';

import '../fnx_ui.dart';

@PolymerRegister("fnx-fieldset")
class FnxFieldset extends PolymerElement {

  @property
  bool animated = true;

  FnxFieldset.created() : super.created();

  void ready() {
    if (animated) {
      onMouseOver.listen((_) => $$("#container").elevation = 2);
      onMouseOut.listen((_) => $$("#container").elevation = 0);
    }
  }

}
