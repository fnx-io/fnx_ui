import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

///
/// One item to reorder must be a child of reorderContainerVertical.
///
/// 
///
@Directive(
    selector: "[fnxTooltip]"
)
class FnxTooltip implements OnInit, OnDestroy {

  @Input()
  Object fnxTooltip;

  HtmlElement itemElement;

  HtmlElement currentTooltip;

  bool mouseIn;

  StreamSubscription<MouseEvent> subsEnter;
  StreamSubscription<MouseEvent> subsExit;

  FnxTooltip(this.itemElement) {
  }

  @override
  void ngOnDestroy() {
    if (subsEnter != null) subsEnter.cancel();
    if (subsExit != null) subsExit.cancel();
    destroyTooltip();
  }

  @override
  void ngOnInit() {
    subsEnter = itemElement.onMouseEnter.listen(mouseEnter);
    subsExit = itemElement.onMouseLeave.listen(mouseLeave);
  }


  void mouseEnter(MouseEvent event) async {
    mouseIn = true;
    await new Future.delayed(new Duration(milliseconds: 300));
    if (mouseIn && currentTooltip == null && fnxTooltip != null) {
      currentTooltip = new DivElement();
      currentTooltip.classes.add("arrow_box");
      currentTooltip.style.position="absolute";
      setTooltipContent(fnxTooltip);
      document.body.children.add(currentTooltip);
      calculateTooltipPosition();
    }
  }

  void mouseLeave(MouseEvent event) {
    mouseIn = false;
    destroyTooltip();
  }

  void calculateTooltipPosition() {
    if (currentTooltip == null) return;
    var parentBoundingBox = itemElement.getBoundingClientRect();

    currentTooltip.classes.removeWhere((s) => s.startsWith("--"));
    currentTooltip.style.top=null;
    currentTooltip.style.left=null;
    currentTooltip.style.bottom=null;
    currentTooltip.style.right=null;
    currentTooltip.style.transform=null;


    // musi se do toho zahrnout i pripadny zoom
    double zoom = double.tryParse(itemElement.getComputedStyle().zoom)??1;

    parentBoundingBox = new Rectangle(
      parentBoundingBox.left * zoom,
      parentBoundingBox.top * zoom,
      parentBoundingBox.width * zoom,
      parentBoundingBox.height * zoom
    );

    Point center = new Point(
        parentBoundingBox.left + (parentBoundingBox.right - parentBoundingBox.left)/2,
        parentBoundingBox.top + (parentBoundingBox.bottom - parentBoundingBox.top)/2
    );
    if (center.x < window.innerWidth * 0.1) {
      // jsme hodne u kraje vlevo
      currentTooltip.classes.add("--right");
      currentTooltip.style.left = "${parentBoundingBox.right + 20}px";
      currentTooltip.style.top = "${center.y}px";
      currentTooltip.style.transform="translateY(-50%)";
    } else if (center.x > window.innerWidth * 0.9) {
      // jsme hodne u kraje vpravo
      currentTooltip.classes.add("--left");
      currentTooltip.style.right="${window.innerWidth - parentBoundingBox.left + 20}px";
      currentTooltip.style.top = "${center.y}px";
      currentTooltip.style.transform="translateY(-50%)";
    } else {
      // nejsme moc u kraje, dame se nahoru nebo dolu
      if (center.y < window.innerHeight / 2) {
        // jsme nahore
        currentTooltip.classes.add("--bottom");
        currentTooltip.style.top = "${parentBoundingBox.bottom + 20}px";
        currentTooltip.style.left="${center.x}px";
        currentTooltip.style.transform="translateX(-50%)";
      } else {
        currentTooltip.classes.add("--top");
        currentTooltip.style.bottom = "${window.innerHeight - parentBoundingBox.top + 20}px";
        currentTooltip.style.left="${center.x}px";
        currentTooltip.style.transform="translateX(-50%)";
      }
    }
  }

  void setTooltipContent(Object content) async {
    if (currentTooltip == null) return;
    if (content == null) return;
    if (content is String) {
      currentTooltip.innerHtml = content;
    } else if (content is Function) {
      setTooltipContent(content());
    } else if (content is Future) {
      currentTooltip.innerHtml = "<span class=preloader></span>";
      Object futureData = await content;
      setTooltipContent(futureData);
    }
  }

  void destroyTooltip() {
    if (currentTooltip != null) {
      currentTooltip.remove();
      currentTooltip = null;
    }
  }

}