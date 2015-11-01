library fnx_ui;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/paper_ripple.dart';
import 'package:polymer_elements/paper_material.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:fnx_ui/ui/fnx_field.dart';

part 'behavior/fnx_event_behavior.dart';




String elementToString(HtmlElement e) {
  return (e.parent == null ? "" :  _singleElementToString(e.parent) + " > ") +_singleElementToString(e);
}

// TODO: hezcejsi
String _singleElementToString(Element e) {
  if (e.id != null && e.id != "") return e.id;
  if (e is InputElement) {
    if (e.name != null && e.name != "") {
      return e.tagName + ":name=${e.name}";
    } else {
      return e.tagName;
    }
  }
  return e.tagName;
}

findParentField(Element e, symbol, {Element notDeeperThen: null}) {
  if (e == null) return null;
  if (notDeeperThen != null && e == notDeeperThen) return null;
  if (e is FnxField) {
    return e;
  }
  return findParentField(e.parent, symbol, notDeeperThen: notDeeperThen);
}


