import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';

///
/// Dulezite poznamecky - itemy, ktere se pretahuji, nesmi mit nastavenou sirku, vysku nebo border.
///
///
@Directive(
    selector: "[reorderContainer]"
)
class FnxReorderContainer {
  
  HtmlElement container;

  FnxReorderContainer(ElementRef element) {
    container = element.nativeElement;
  }

  HtmlElement _dragged = null;
  
  HtmlElement get dragged => _dragged;

  set dragged(HtmlElement value) {
    if (value == null) {
      // removing element from dragging
      if (_dragged != null) {
        _dragged.style.opacity = null;
      }
    }
    _dragged = value;
    if (_dragged != null) {
      // element is dragged, hide it
      _dragged.style.opacity = "0.6";
    }
  }

  @Output()
  EventEmitter<ReorderEvent> reorder = new EventEmitter();

  void emit(HtmlElement e) {
    int from = container.children.indexOf(dragged);
    int to = container.children.indexOf(e);
    reorder.emit(new ReorderEvent(from, to));
  }

}

///
/// Event of reorder - destination index is valid AFTER you remove item from source index.
///
/// Consider using convenient applyToList method.
///
///
class ReorderEvent {

  int sourceIndex;
  int destinationIndex;

  ReorderEvent(this.sourceIndex, this.destinationIndex);

  void applyToList(List data) {
    data.insert(destinationIndex, data.removeAt(sourceIndex));
  }

}

///
/// One item to reorder must be a child of reorderContainerVertical.
///
/// 
///
@Directive(
    selector: "[reorderItem]"
)
class FnxReorderItem {

  FnxReorderContainer parent;
  HtmlElement itemElement;

  bool get beingDragged => parent.dragged == itemElement;

  FnxReorderItem(ElementRef elementRef, this.parent) {
    itemElement = (elementRef.nativeElement as HtmlElement);
    itemElement.draggable = true;

    //if (e.parent != parent.container) throw "reorderItem MUST be direct child of reorderContainerVertical";

    itemElement.onDragStart.listen((MouseEvent ev) {
      // I'm being dragged somewhere.
      parent.dragged = itemElement;
    });

    itemElement.onDragEnd.listen((MouseEvent ev) {
      ev.preventDefault();
      parent.dragged = null;
    });

    itemElement.onDragEnter.listen((MouseEvent ev) {
      if (beingDragged) return;
      // something is dragged over me, and it's not me
      parent.emit(itemElement);
    });

  }
  

}