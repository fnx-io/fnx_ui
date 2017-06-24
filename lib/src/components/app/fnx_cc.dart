// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:cookie/cookie.dart' as cookie;
import 'package:fnx_ui/src/util/global_messages.dart';
import 'package:logging/logging.dart';

///
/// Cookies consent.
///
@Component(
  selector: 'fnx-cc',
  template: """
  <div *ngIf="visible" class="fnx__cc flex--row bg--accent">
    <div class="spacer padding">
      <ng-content></ng-content>
    </div>
    <div class="padding">
      <button class="btn" type="button" (click)="agree()">{{label}}</button>
    </div>
  </div>
  """,
  styles: const ["""
  :host {
    display: block;
    position: fixed;
    left:0;
    right:0;
    bottom:0;
    width:100%;
  }
  """],
  preserveWhitespace: false
)
class FnxCC implements OnInit {

  final Logger log = new Logger("FnxCC");

  bool visible = false;

  @Input()
  String label = GlobalMessages.ok();

  void agree() {
    cookie.set("fnxcc", "agreed", expires: 150, path: "/");
    visible = false;
  }

  @override
  ngOnInit() {
    String val = cookie.get("fnxcc");
    if (val == null) {
      visible = true;
      return;
    }
    if (val == "agreed") {
      visible = false;
      return;
    }
    visible = true;
    return;
  }

}
