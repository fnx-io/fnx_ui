// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:logging/logging.dart';


typedef bool _KeyListener(KeyboardEvent e);

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
  preserveWhitespace: false,
  directives: [
    coreDirectives,
    formDirectives,
  ],
)
class FnxModal implements OnInit, OnDestroy {

  Set<dynamic> activeChilds = new Set();

  static List<FnxModal> _stack = [];

  final Logger log = new Logger("FnxModal");

  String id = ui.uid('modal-');

  ///
  /// Optional CSS width of this modal window. Possibly 90vw etc.
  @Input()
  String width = null;

  StreamController<bool> _close = new StreamController();

  ///
  /// Output. Catch it and hide this window, user clicked the "close" icon.
  ///
  @Output()
  Stream<bool> get close => _close.stream;

  StreamSubscription<KeyboardEvent> keyDownSubscription;

  void emitClose() {
    _close.add(false);
  }

  @override
  ngOnInit() {
    _stack.add(this);
    keyDownSubscription = document.onKeyDown
        .where(tryOrFalse((KeyboardEvent e) => e.keyCode == KeyCode.ESC))
        .where(tryOrFalse((KeyboardEvent e) => this == _stack.last))
        .where(tryOrFalse((KeyboardEvent e) => activeChilds.isEmpty))
        .listen((KeyboardEvent e) {
      if (_stack.isEmpty || _stack.last == this) {
        print("Closing!");
        ui.killEvent(e);
        emitClose();
      }
    });
  }

  @override
  ngOnDestroy() {
    keyDownSubscription.cancel();
    _stack.remove(this);
  }

  _KeyListener tryOrFalse(_KeyListener fnc) {
    return (KeyboardEvent e) {
      try {
        return fnc(e);
      } catch (ex) {
        log.info("Very strange exception here: $ex");
        return false;
      }
    };
  }

}
