// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:html';

///
/// Nice "fieldset". It should have a header, defined with attribute 'header'. Like this:
///
///       <fnx-panel>
///           <h3 header>Address</h1>
///           <p header>Please fill your address</p>
///           <div>Panel content ...</div>
///       </fnx-panel>
///
@Component(
  selector: 'fnx-panel',
  templateUrl: 'fnx_panel.html',
  preserveWhitespace: false
)
class FnxPanel implements OnInit {

  final Logger log = new Logger("FnxPanel");

  ///
  /// Input. Can by collapsed or expanded by user. Default = false = always open.
  ///
  @Input()
  bool closable = false;

  @Input()
  bool open = null;

  String id = ui.uid('panel-');

  @override
  ngOnInit() {
    if (closable == null) closable = false;
    if (open == null) {
      open = !closable;
    }
  }
}
