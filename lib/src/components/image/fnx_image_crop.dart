// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular2/core.dart';
import 'package:fnx_ui/src/util/async.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;

@Component(
    selector: 'fnx-image-crop',
    styles: const [
      "div { overflow: hidden; position: relative; } ",
      "img { position: absolute; cursor: move; } ",
      "p { position: absolute; left:0; bottom:0; right:0}",
      "p span { opacity: 0.7 }",
      "p span:hover { opacity: 1 }",
    ],
    template: """
<div class="border" #mask
  [style.height.px]="maskHeight"
><img src="{{src}}" #img
  [style.top.px]="imgOffsetY"
  [style.left.px]="imgOffsetX"
  [style.width.px]="imgWidth"
  [style.height.px]="imgHeight"
  (dragstart)="killEvent(\$event)"
  (mousemove)="moveImage(\$event)"
/><p class="text--center">
  <span class="btn icon margin--small--right" (mousedown)='zoomOut(\$event)'>zoom_out</span>
  <span class="btn icon" (mousedown)='zoomIn(\$event)'>zoom_in</span>
</p></div>
    """
)
class FnxImageCrop implements OnInit, OnChanges{

  /// Required crop ratio - width:height
  @Input()
  double ratio = 1.0;

  @Input()
  String src = null;

  @ViewChild('mask')
  ElementRef maskRef;

  @ViewChild('img')
  ElementRef imgRef;

  @Output()
  EventEmitter<Rectangle<double>> crop = new EventEmitter();

  int maskHeight = 0;
  int get maskWidth => mask?.getBoundingClientRect().width.ceil();

  int imgSourceWidth = 0;
  int imgSourceHeight = 0;

  int imgWidth = null;
  int imgHeight = null;

  double imgOffsetX = 0.0;
  double imgOffsetY = 0.0;

  double zoom = 1.0;

  DivElement mask;
  ImageElement img;

  @override
  ngOnInit() {
    mask = maskRef.nativeElement;
    img = imgRef.nativeElement;

    window.onResize.transform(new FnxStreamDebouncer(new Duration(milliseconds: 100))).listen(updateMask);

    updateMask();
    loadImageDimensions();
  }

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
    changes.forEach((String propName, SimpleChange change) {
      if (propName == "ratio") {
        updateMask();
      }
      if (propName == "src") {
        // image updated
        loadImageDimensions();
      }
    });
  }

  void loadImageDimensions() {
    if (img == null) return;
    img.onLoad.listen((Event e) {
      imgSourceWidth = img.clientWidth;
      imgSourceHeight = img.clientHeight;
      updateImage();
    });
  }

  int countMaskHeight() {
    if (mask == null) {
      return 0;
    }
    if (ratio == null || ratio <= 0) {
      ratio = 1.0;
    }
    return (maskWidth / ratio).round();
  }

  void updateMask([_]) {
    //print("Updating mask");
    maskHeight = countMaskHeight();
    updateImage();
  }

  void updateImage() {
    if (mask == null || img == null || imgSourceWidth == 0 || imgSourceHeight == 0) return;

    imgWidth = imgSourceWidth;
    imgHeight = imgSourceHeight;

    if (imgWidth < maskWidth || imgHeight < maskHeight) {
      // moc malej, musi se zvetsit!
      if (imgWidth < maskWidth) {
        // moc uzkej!
        double resize = maskWidth / imgSourceWidth;
        imgWidth = maskWidth;
        imgHeight = (imgSourceHeight * resize).ceil();
      }

      if (imgHeight < maskHeight) {
        // moc nizkej!
        double resize = maskHeight / imgHeight;
        imgHeight = maskHeight;
        imgWidth = (imgWidth * resize).ceil();
      }
    } else {
      // moc velkej, musi se zmensit
      double resize = maskWidth / imgSourceWidth;
      imgWidth = maskWidth;
      imgHeight = (imgSourceHeight * resize).ceil();

      if (imgHeight < maskHeight) {
        // no, to se zmensil moc!
        double resize = maskHeight / imgHeight;
        imgHeight = maskHeight;
        imgWidth = (imgWidth * resize).ceil();
      }

    }
    imgWidth = (imgWidth * zoom).floor();
    imgHeight = (imgHeight * zoom).floor();

    trimOffsetToBoundaries();
    emitCropResult();
  }

  void emitCropResult() {
    if (imgWidth <= 0 || imgHeight <= 0) return;
    double left = (imgOffsetX / imgWidth).abs();
    double top = (imgOffsetY / imgHeight).abs();
    double width = maskWidth / imgWidth;
    double height = maskHeight / imgHeight;
    if (top + height > 1) height = 1 -top;
    crop.emit(new Rectangle(left, top, width, height));
  }

  void moveImage(MouseEvent event) {
    // if mouse down
    if (event.buttons == 1) {

      imgOffsetX += event.movement.x;
      imgOffsetY += event.movement.y;

      trimOffsetToBoundaries();
      emitCropResult();

    }
    killEvent(event);
  }

  void trimOffsetToBoundaries() {
    if (imgOffsetY > 0) imgOffsetY = 0.0;
    if (maskHeight - imgOffsetY > imgHeight) imgOffsetY = (maskHeight - imgHeight).toDouble();
    if (imgOffsetX > 0) imgOffsetX = 0.0;
    if (maskWidth - imgOffsetX > imgWidth) imgOffsetX = (maskWidth - imgWidth).toDouble();
  }

  void zoomIn(Event event) {
    killEvent(event);
    Point<double> center = getCenter();
    zoom = zoom * 1.2;
    if (zoom > 5) zoom = 5.0;
    updateImage();
    centerTo(center);
  }

  void zoomOut(Event event) {
    killEvent(event);
    Point<double> center = getCenter();
    zoom = zoom / 1.2;
    if (zoom < 1) zoom = 1.0;
    updateImage();
    centerTo(center);
  }

  void killEvent(Event event) {
    ui.killEvent(event);
  }

  Point<double> getCenter() {
    double cx = (maskWidth/2.0 - imgOffsetX) / imgWidth.toDouble();
    double cy = (maskHeight/2.0 - imgOffsetY)/ imgHeight.toDouble();
    return new Point(cx, cy);
  }

  void centerTo(Point<double> center) {
    imgOffsetX = (maskWidth/2.0) - (center.x * imgWidth);
    imgOffsetY = (maskHeight/2.0) - (center.y * imgHeight);
    trimOffsetToBoundaries();
    emitCropResult();
  }

}
