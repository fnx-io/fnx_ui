import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';

///
/// Dulezite poznamecky - itemy, ktere se pretahuji, nesmi mit nastavenou sirku, vysku nebo border.
///
///

abstract class FnxReorderContainer {

  bool isVertical();

  HtmlElement container;

  FnxReorderContainer(ElementRef element) {
    container = element.nativeElement;
  }

  HtmlElement _dragged = null;
  int draggedHeight = 0;
  int draggedWidth = 0;


  HtmlElement get dragged => _dragged;

  set dragged(HtmlElement value) {
    if (value == null) {
      // removing element from dragging
      if (_dragged != null) {
        _dragged.style.display = null;
        draggedHeight = 0;
        draggedWidth = 0;
      }
    }
    _dragged = value;
    if (_dragged != null) {
      // element is dragged, hide it
      draggedHeight = _dragged.getBoundingClientRect().height.toInt();
      draggedWidth = _dragged.getBoundingClientRect().width.toInt();
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
    selector: "[reorderContainerVertical]",
    outputs: const ['reorder'],
    providers: const [
      const Provider(FnxReorderContainer, useExisting: FnxReorderContainerVertical, multi: false)
    ]
)
class FnxReorderContainerVertical extends FnxReorderContainer {

  FnxReorderContainerVertical(ElementRef element):super(element);

  @override
  bool isVertical() {
    return true;
  }
}

@Directive(
    selector: "[reorderContainerHorizontal]",
    outputs: const ['reorder'],
    providers: const [
      const Provider(FnxReorderContainer, useExisting: FnxReorderContainerHorizontal, multi: false)
    ]
)
class FnxReorderContainerHorizontal extends FnxReorderContainer {

  FnxReorderContainerHorizontal(ElementRef element):super(element);

  @override
  bool isVertical() {
    return false;
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
  bool _beingDragged = false;

  bool get vertical => parent.isVertical();

  FnxReorderItem(ElementRef elementRef, this.parent) {
    itemElement = (elementRef.nativeElement as HtmlElement);
    itemElement.draggable = true;

    //if (e.parent != parent.container) throw "reorderItem MUST be direct child of reorderContainerVertical";

    itemElement.onDragStart.listen((_) {
      // I'm being dragged somewhere.
      _beingDragged = true;
      parent.dragged = itemElement;
    });

    itemElement.onDragEnd.listen((MouseEvent ev) {
      // Drag ended, let's just clean up.
      _beingDragged = false;
      parent.dragged = null;
    });

    itemElement.onDragEnter.listen((MouseEvent ev) {
      if (_beingDragged) return;
      // something is dragged over me, and it's not me
      updateBorder(ev);
      parent.dragged.style.display="none";
    });

    itemElement.onDragOver.listen((MouseEvent ev) {
      if (_beingDragged) return;
      // something is dragged over me, and it's not me
      updateBorder(ev);
      ev.preventDefault();
    });

    itemElement.onDragLeave.listen((MouseEvent ev) {
      // something WAS dragged over me, but not anymore
      itemElement.style.borderBottom = null;
      itemElement.style.borderTop = null;
      itemElement.style.borderLeft = null;
      itemElement.style.borderRight = null;
    });

    itemElement.onDrop.listen((MouseEvent ev) {
      //dragInfo(ev);
      var itemElementSize = itemElement.getBoundingClientRect();

      if (vertical) {
        num relY = ev.client.y - itemElementSize.top;
        parent.dragFinished(itemElement, relY > itemElementSize.height / 2);

      } else {
        num relX = ev.client.x - itemElementSize.left;
        parent.dragFinished(itemElement, relX > itemElementSize.width / 2);

      }

      parent.dragged.style.display=null;
      parent.dragged = null;

      itemElement.style.borderBottom = null;
      itemElement.style.borderTop = null;
      itemElement.style.borderLeft = null;
      itemElement.style.borderRight = null;
    });
  }

  void updateBorder(MouseEvent ev) {
    var itemElementSize = itemElement.getBoundingClientRect();

    if (vertical) {
      num relY = ev.client.y - itemElementSize.top;
      if (relY > itemElementSize.height / 2) {
        itemElement.style.borderBottom = generateBorder();
        itemElement.style.borderTop = null;
      } else {
        itemElement.style.borderTop = generateBorder();
        itemElement.style.borderBottom = null;
      }
    } else {
      num relX = ev.client.x - itemElementSize.left;
      if (relX > itemElementSize.width / 2) {
        itemElement.style.borderRight = generateBorder();
        itemElement.style.borderLeft = null;
      } else {
        itemElement.style.borderLeft = generateBorder();
        itemElement.style.borderRight = null;
      }
    }
  }

  String generateBorder() {
    if (parent.dragged == null) return null;
    if (vertical) {
      return "${parent.draggedHeight}px solid #eee";
    } else {
      return "${parent.draggedWidth}px solid #eee";
    }
  }


/*
  String dragInfo(MouseEvent ev) {
    var size = e.getBoundingClientRect();
    num relY = ev.client.y - size.top;
    print(parent.dragged.innerHtml + (relY > size.height/2 ? ' bellow ' : ' above ' ) + this.e.innerHtml);
  }
  */

}