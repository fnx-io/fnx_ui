import 'package:angular2/common.dart';
import 'dart:html';
import 'dart:async';

int idCounter = 1;
/// Generates unique string each time called. When called with a prefix param
/// the resulting String will be prefixed, the default prefix is gen__.
String uid([String prefix]) {
  if (prefix == null) prefix = "gen__";
  int id = idCounter;
  idCounter += 1;
  return prefix + id.toRadixString(16);
}

bool hasError(NgControl ctrl) {
  return ctrl != null && !ctrl.valid;
}

/// returns true if target can be found in potentialParent's DOM subtree
bool isParentNodeOf(Node target, Node potentialParent) {
  var root = document;
  while (target != root) {
    if (target == potentialParent) return true;
    target = target.parentNode;
  }
  return false;
}

/// returns true, if event has been fired from DOM subtree of given parent
bool isEventFromSubtree(Event event, Node parent) {
  if (event == null || !(event.target is Node) || parent == null) return false;
  return isParentNodeOf(event.target, parent);
}

Set<String> activeElementTags = new Set.from(["A", "INPUT", "TEXTAREA", "BUTTON"]);
/// returns true if given node is "active" element.
/// Active elements are those which have some user interaction when working with them.
/// Inputs, buttons, links, ...
bool isActiveElement(Node node) {
  if (!(node is Element)) return false;
  Element el = node as Element;
  return activeElementTags.contains(el.tagName);
}


/// returns stream of element's position on the screen as a number between 0 and 1,
/// or negative, if element is above the viewport, or bigger then 1
/// if the element is below the viewport.
Stream<double> elementPositionStream(Element e) {
  // TODO: merge with onResize stream
  return window.onScroll.transform(
      new StreamTransformer<Event, double>.fromHandlers(
          handleData: (Event event, EventSink<double> sink) {
            Rectangle r = e.getBoundingClientRect();
            double center = r.top + ((r.bottom - r.top) / 2.0);
            sink.add(center / window.innerHeight.toDouble());
          }
      )
  );
}