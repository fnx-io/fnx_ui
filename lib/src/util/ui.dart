import 'dart:async';
import 'dart:html';

import 'package:angular_forms/angular_forms.dart';
import 'package:async/async.dart';
import 'package:fnx_ui/src/util/async.dart';

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
  while (target != root && target != null) {
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

/// Stops the event from propagation and prevents default action
void killEvent(Event e) {
  if (e == null) return;
  e.preventDefault();
  e.stopPropagation();
}

/// returns stream of element's position on the screen as a number between 0 and 1,
/// or negative, if element is above the viewport, or bigger then 1
/// if the element is below the viewport.
Stream<double> verticalElementPositionStream(Element e) {

  Stream<Event> mergedRelevant = StreamGroup.merge([window.onMouseWheel, window.onResize]);

  return mergedRelevant.transform(
      new StreamTransformer<Event, double>.fromHandlers(
          handleData: (Event event, EventSink<double> sink) {
            Rectangle r = e.getBoundingClientRect();
            double center = r.top + ((r.bottom - r.top) / 2.0);
            sink.add(center / window.innerHeight.toDouble());
          }
      )
  );
}

///
/// Nejakym takovym chytristikou bysme meli delat vsechny dropdowny.
///
class DropdownTracker {

  Element _element;
  Element _dropdown;
  Function _onHide;

  int top = 10000;
  int left = 10000;
  String dropdownHeight = "auto";
  bool downOnly;

  StreamSubscription<Event> subscription;

  DropdownTracker({this.downOnly : false}) {
  }

  void init(Element container, Element dropdown, Function onHide) {
    this._element = container;
    this._dropdown = dropdown;
    this._onHide = onHide;
    Stream<Event> mergedRelevant = StreamGroup.merge([window.onMouseWheel, window.onResize, window.onScroll]);
    FnxStreamDebouncer<Event> db = new FnxStreamDebouncer(new Duration(milliseconds: 10));
    subscription = mergedRelevant.transform(db).listen(updatePosition);
  }

  void destroy() {
    this._element = null;
    subscription.cancel();
  }

  void updatePosition([_]) {
    int scrHeight = window.innerHeight.toInt();
    int dropdownH = _dropdown.getBoundingClientRect().height.toInt();
    if (_element != null) {
      Rectangle<num> el = _element.getBoundingClientRect();

      if (el.top < 0) {
        _onHide();
        return;
      }
      if (el.top > scrHeight) {
        _onHide();
        return;
      }
      left = el.left.toInt();

      if (downOnly || dropdownH + el.top + el.height < scrHeight) {
        // vejde se dolu
        top = el.top.toInt() + el.height.toInt();

      } else {
        if (el.top - dropdownH > 0) {
          // vejde se nahoru
          top = el.top.toInt() - dropdownH;

        } else {
          top = (scrHeight - dropdownH)~/2;
        }
      }
    }
  }

}
