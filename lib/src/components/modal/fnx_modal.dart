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
@Component(selector: 'fnx-modal', templateUrl: 'fnx_modal.html', preserveWhitespace: false)
class FnxModal implements OnInit, OnDestroy {
  Set<dynamic> activeChilds = new Set();

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
        .where((e) => e is KeyboardEvent)
        .where(tryOrFalse((KeyboardEvent e) => this == _stack.last))
        .where(tryOrFalse((KeyboardEvent e) => activeChilds.isEmpty))
        .where(tryOrFalse((KeyboardEvent e) => e.keyCode == KeyCode.ESC))
        .listen((KeyboardEvent e) {
      if (_stack.isEmpty || _stack.last == this) {
        print("Closing!");
        ui.killEvent(e);
        close.emit(false);
      }
    });
  }

  @override
  ngOnDestroy() {
    keyDownSubscription.cancel();
    _stack.remove(this);
  }

  Function tryOrFalse(Function fnc) {
    return (Object e) {
      try {
        return fnc(e as KeyboardEvent);
      } catch (ex) {
        log.info("Very strange exception here: $ex");
        return false;
      }
    };
  }
}
