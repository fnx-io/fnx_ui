// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:html';
import 'package:fnx_ui/src/util/html.dart';

@Component(
  selector: 'fnx-modal',
  templateUrl: 'fnx_modal.html'
)
class FnxModal {

  final Logger log = new Logger("FnxModal");

  String id = ui.uid('modal-');

  @Output()
  EventEmitter<bool> close = new EventEmitter<bool>();

  void emitClose() {
    close.emit(true);
  }

}
