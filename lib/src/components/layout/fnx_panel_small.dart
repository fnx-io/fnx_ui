// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:html';

@Component(
  selector: 'fnx-panel-small',
  templateUrl: 'fnx_panel_small.html'
)
class FnxPanelSmall {

  final Logger log = new Logger("FnxPanelSmall");

  @Input()
  String closable;

  bool get isClosable => closable != null;

  @Input()
  bool open = false;

  String id = ui.uid('panel-');

}
