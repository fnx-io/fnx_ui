// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:async';

@Component(
  selector: 'fnx-app',
  templateUrl: 'fnx_app.html'
)
class FnxApp implements OnInit {

  final Logger log = new Logger("FnxApp");

  Map<String, _ModalContent> modalWindows = {};
  List<_ToastContent> toasts = [];

  FnxApp() {
  }

  ngOnInit() {
    log.fine("App started");
  }

  // TOASTS

  Future toast(String text, {Duration duration: const Duration(milliseconds: 4000 )}) {
    _ToastContent t = new _ToastContent()
        ..message = text;
    toasts.add(t);
    new Future.delayed(duration).then((_) => t.hide = true);
    new Future.delayed(duration + const Duration(seconds: 1)).then((_) {
      if (toasts.firstWhere((_ToastContent t) => t.hide == false, orElse: () => null) == null) {
        toasts.clear();
      }
    });
  }

  // MODAL WINDOWS

  Future alert(String message, {String headline: "Message"}) {
    _ModalContent m = new _ModalContent()
      ..headline = headline
      ..message = message
      ..ok="ok";
    return _modal(m);
  }

  Future<bool> confirm(String message, {String headline: "Confirm"}) {
    _ModalContent m = new _ModalContent()
      ..headline = headline
      ..message = message
      ..ok="yes"
      ..cancel="no";
    return _modal(m);
  }

  Future<Object> input(String message, {String headline: "Input value"}) {
    _ModalContent m = new _ModalContent()
      ..headline = headline
      ..message = message
      ..input = "text"
      ..ok="ok"
      ..cancel="cancel";
    return _modal(m);
  }

  Future _modal(_ModalContent mc) {
    StreamController streamController = new StreamController();
    mc._stream = streamController;
    modalWindows[mc.id] = mc;
    return streamController.stream.first;
  }

  void closeModal(String id, bool closingResult) {
    _ModalContent mc = modalWindows[id];
    if (mc == null) return;
    modalWindows.remove(id);

    if (mc.input != null) {
      // input mode
      if (closingResult) {
        // ok
        mc._stream.add(mc.value);
      } else {
        // cancel
        mc._stream.add(null);
      }

    } else {
      // common alert
      mc._stream.add(closingResult);
    }

    mc._stream.close();
  }

}

class _ModalContent {
  String id = ui.uid('modal-');
  String headline;
  String message;
  String ok;
  String cancel;
  String input;
  var value;
  StreamController _stream;
}

class _ToastContent {
  String message;
  bool hide = false;
}