import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';

///
/// Container for items which can be reordered by drag and drop.
///
/// Items should be vertically oriented.
///
/// 
///        <ul reorderContainerVertical (reorder)="doReorder($event)" >
///             <li reorderItem *ngFor="let item of reorderItems">{{item}}</li>
///        </ul>
///
/// 
///        void doReorder(ReorderEvent ev) {
///             ev.applyToList(reorderItems);
///        }
///
/// 
@Directive(
    selector: "[reorderContainerVertical]"
)
class FnxReorderContainerVertical {

  HtmlElement container;

  FnxReorderContainerVertical(ElementRef element) {
    container = element.nativeElement;
  }

  HtmlElement _dragged = null;
  int draggedHeight = 0;


  HtmlElement get dragged => _dragged;

  set dragged(HtmlElement value) {
    if (value == null) {
      // removing element from dragging
      if (_dragged != null) {
        _dragged.style.display = null;
        draggedHeight = 0;
      }
    }
    _dragged = value;
    if (_dragged != null) {
      // element is dragged, hide it
      draggedHeight = _dragged.getBoundingClientRect().height.toInt();
    }
  }

  @Output()
  EventEmitter<ReorderEvent> reorder = new EventEmitter();

  void dragFinished(HtmlElement e, bool bellow) {
    //print("${dragged.innerHtml} to ${e.innerHtml} bellow=$bellow");
    if (dragged == null) return;
    if (e == null) return;

    int from = container.children.indexOf(dragged);
    int to = container.children.indexOf(e);
    if (!bellow) to = to - 1;
    if (to < from) {
      to+=1;
    }

    //print("Reorder $from => $to");
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

  FnxReorderContainerVertical parent;
  HtmlElement e;
  bool _beingDragged = false;

  FnxReorderItem(ElementRef elementRef, this.parent) {
    e = (elementRef.nativeElement as HtmlElement);
    e.draggable = true;

    //if (e.parent != parent.container) throw "reorderItem MUST be direct child of reorderContainerVertical";

    e.onDragStart.listen((_) {
      // I'm being dragged somewhere.
      _beingDragged = true;
      parent.dragged = e;
    });

    e.onDragEnd.listen((MouseEvent ev) {
      // Drag ended, let's just clean up.
      _beingDragged = false;
      parent.dragged = null;
    });

    e.onDragEnter.listen((MouseEvent ev) {
      if (_beingDragged) return;
      // something is dragged over me, and it's not me
      updateBorder(ev);
      parent.dragged.style.display="none";
    });

    e.onDragOver.listen((MouseEvent ev) {
      if (_beingDragged) return;
      // something is dragged over me, and it's not me
      updateBorder(ev);
      ev.preventDefault();
    });

    e.onDragLeave.listen((MouseEvent ev) {
      // something WAS dragged over me, but not anymore
      e.style.borderBottom = null;
      e.style.borderTop = null;
    });

    e.onDrop.listen((MouseEvent ev) {
      //dragInfo(ev);
      var size = e.getBoundingClientRect();
      num relY = ev.client.y - size.top;
      parent.dragFinished(e, relY > size.height/2);
      parent.dragged.style.display=null;
      parent.dragged = null;
      e.style.borderBottom = null;
      e.style.borderTop = null;
    });
  }

  void updateBorder(MouseEvent ev) {
    var size = e.getBoundingClientRect();
    num relY = ev.client.y - size.top;
    if (relY > size.height/2) {
      e.style.borderBottom = generateBorder();
      e.style.borderTop = null;
    } else {
      e.style.borderTop = generateBorder();
      e.style.borderBottom = null;
    }
  }

  String generateBorder() {
    if (parent.dragged == null) return null;
    return "${parent.draggedHeight}px solid #eee";
  }


/*
  String dragInfo(MouseEvent ev) {
    var size = e.getBoundingClientRect();
    num relY = ev.client.y - size.top;
    print(parent.dragged.innerHtml + (relY > size.height/2 ? ' bellow ' : ' above ' ) + this.e.innerHtml);
  }
  */

}