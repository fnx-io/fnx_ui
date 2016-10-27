// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:html';

@Component(
  selector: 'fnx-panel-small',
  templateUrl: 'fnx_panel_small.html',
  preserveWhitespace: false
)
class FnxPanelSmall extends FnxPanel implements OnInit {

  @Input()
  bool closable = false;

  @Input()
  bool open = null;

}
