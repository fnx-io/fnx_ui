import 'dart:html';

///
/// This element can request focus.
///

import 'package:angular2/core.dart';
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

  AutoFocus(this.element, @Optional() this.focusable);

  @override
  ngOnInit() {
    if (focusable != null) {
      focusable.focus();

    } else if (element.nativeElement is HtmlElement) {
      element.nativeElement.focus();
    }

  }

}