// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:angular2/core.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:logging/logging.dart';

///
/// Basic empty modal window. Show it with *ngIf="something". Window emits
/// (close) event, use it to set something=false.
///
/// Window content is ".layout--header", which you can fill using attributes: header, main, footer. Like this:
///
///      <fnx-modal *ngIf="showMyModal" (close)="showMyModal = false">
///          <h1 header>Window header</h1>
///          <p main>Window content</p>
///          <p footer>Window footer</p>
///      </fnx-modal>
///
///
@Component(
  selector: 'fnx-modal',
  templateUrl: 'fnx_modal.html',
  preserveWhitespace: false
)
class FnxModal implements OnInit, OnDestroy {

  static List<FnxModal> _stack = [];

  final Logger log = new Logger("FnxModal");

  String id = ui.uid('modal-');

  ///
  /// Optional CSS width of this modal window. Possibly 90vw etc.
  @Input()
  String width = null;

  ///
  /// Output. Catch it and hide this window, user clicked the "close" icon.
  ///
  @Output()
  EventEmitter<bool> close = new EventEmitter<bool>();

  StreamSubscription<KeyboardEvent> keyDownSubscription;

  void emitClose() {
    close.emit(false);
  }

  @override
  ngOnInit() {
    _stack.add(this);
    keyDownSubscription = document.onKeyDown
        .where((KeyboardEvent e) => this == _stack.last)
        .where((KeyboardEvent e) => e.keyCode == KeyCode.ESC)
        .listen((KeyboardEvent e) {
      ui.killEvent(e);
      close.emit(false);
    });
  }

  @override
  ngOnDestroy() {
    keyDownSubscription.cancel();
    _stack.remove(this);
  }

}
