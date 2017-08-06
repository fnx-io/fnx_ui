import 'dart:async';
import 'dart:html';

///
/// This element can request focus.
///

import 'package:angular2/core.dart';
///
/// This element can request focus.
///

///
/// This element can request focus.
///


abstract class Focusable {

  void focus();

}

@Directive(
  selector: "[autoFocus]"
)
class AutoFocus implements OnInit {

  ElementRef element;
  Focusable focusable;

  @Input()
  dynamic autoFocus;

  AutoFocus(this.element, @Optional() this.focusable);

  @override
  ngOnInit() {
    doFocus();
    new Future.delayed(new Duration(milliseconds: 50)).then(doFocus);
  }

  void doFocus([_]) {
    if (autoFocus == false) return;
    if (focusable != null) {
      focusable.focus();
    } else if (element.nativeElement is HtmlElement) {
      element.nativeElement.focus();
    }
  }

}