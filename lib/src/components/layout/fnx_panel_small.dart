// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:html';

///
/// Nice "fieldset", smaller and less contrasting then fnx-panel.. It should have a header, defined with attribute 'header'. Like this:
///
///      <fnx-panel-small>
///          <h1 header>Address</h1>
///          <p header>Please fill your address</p>
///          <div>Panel content ...</div>
///      </fnx-panel-small>
///
@Component(
  selector: 'fnx-panel-small',
  templateUrl: 'fnx_panel_small.html',
  styles: const [":host {display: block;}"],
  preserveWhitespace: false
)
class FnxPanelSmall extends FnxPanel implements OnInit {

  ///
  /// Input. Can by collapsed or expanded by user. Default = false = always open.
  ///
  @Input()
  bool closable = false;

  @Input()
  bool open = null;

}
