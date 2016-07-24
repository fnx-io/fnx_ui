// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:html';
import 'package:fnx_ui/src/util/html.dart';
import 'dart:async';

@Component(
  selector: 'fnx-modal',
  templateUrl: 'fnx_modal.html'
)
class FnxModal implements OnInit, OnDestroy {

  final Logger log = new Logger("FnxModal");

  String id = ui.uid('modal-');

  @Output()
  EventEmitter<bool> close = new EventEmitter<bool>();

  StreamSubscription<KeyboardEvent> keyDownSubscription;

  void emitClose() {
    close.emit(false);
  }

  @override
  ngOnInit() {
    keyDownSubscription = document.onKeyDown.where((KeyboardEvent e) => e.keyCode == KeyCode.ESC).listen((KeyboardEvent e) {
      close.emit(false);
    });
  }


  @override
  ngOnDestroy() {
    keyDownSubscription.cancel();
  }
}
