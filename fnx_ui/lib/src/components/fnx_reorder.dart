import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

///
/// Dulezite poznamecky - itemy, ktere se pretahuji, nesmi mit nastavenou sirku, vysku nebo border.
///
///
@Directive(selector: "[reorderContainer]")
class FnxReorderContainer {
  HtmlElement container;

  FnxReorderContainer(this.container);

  FnxReorderItem? _dragged = null;
  int? _draggedIndex;

  FnxReorderItem? get dragged => _dragged;
  int? get draggedIndex => _draggedIndex;

  set dragged(FnxReorderItem? value) {
    if (value == null) {
      // removing element from dragging
      if (_dragged != null) {
        _dragged!.itemElement.style.opacity = "";
        _draggedIndex = null;
      }
    }
    _dragged = value;
    if (_dragged != null) {
      // element is dragged, hide it
      _dragged!.itemElement.style.opacity = "0.6";
      _draggedIndex = _dragged!.reorderItem;
    }
    print("Dragged: $_dragged  $draggedIndex");
  }

  StreamController<ReorderEvent> _reorder = new StreamController();
  @Output()
  Stream<ReorderEvent> get reorder => _reorder.stream;

  void emitReorder(FnxReorderItem target) {
    if (_dragged == null) {
      // we are not dragging anything, probably other reorderContainer on page
      return;
    }
    int? from = _draggedIndex;
    int? to = target.reorderItem;
    if (from == to) {
      // unnecessary
      return;
    }
    print("Reorder from=$from to=$to");
    _reorder.add(new ReorderEvent(from, to));
    _draggedIndex = to;
  }
}

///
/// Event of reorder - destination index is valid AFTER you remove item from source index.
///
/// Consider using convenient applyToList method.
///
///
class ReorderEvent {
  int? sourceIndex;
  int? destinationIndex;

  ReorderEvent(this.sourceIndex, this.destinationIndex);

  void applyToList(List data) {
    data.insert(destinationIndex!, data.removeAt(sourceIndex!));
  }
}

///
/// One item to reorder must be a child of reorderContainerVertical.
///
///
///
@Directive(selector: "[reorderItem]")
class FnxReorderItem {
  @Input()
  int? reorderItem;

  FnxReorderContainer parent;
  HtmlElement itemElement;

  bool get beingDragged => parent.draggedIndex == reorderItem;

  FnxReorderItem(this.itemElement, this.parent) {
    itemElement.draggable = true;

    //if (e.parent != parent.container) throw "reorderItem MUST be direct child of reorderContainerVertical";

    itemElement.onDragStart.listen((MouseEvent ev) {
      // I'm being dragged somewhere.
      if (reorderItem == null) {
        throw "You must specify index of reorderItem: [reorderItem]='1'";
      }
      ev.dataTransfer.dropEffect = "none";
      parent.dragged = this;
    });

    itemElement.onDragEnd.listen((MouseEvent ev) {
      ev.preventDefault();
      parent.dragged = null;
    });

    itemElement.onDragEnter.listen((MouseEvent ev) {
      if (beingDragged) return;
      // something is dragged over me, and it's not me
      parent.emitReorder(this);
    });
  }
}
