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

  Map<String, ModalContent> modalWindows = {};

  FnxApp() {
  }

  ngOnInit() {
    log.fine("App started");
  }

  // MODAL WINDOWS

  Future alert(String message, {String headline: "Message"}) {
    ModalContent m = new ModalContent()
      ..headline = headline
      ..message = message
      ..ok="ok";
    return _modal(m);
  }

  Future<bool> confirm(String message, {String headline: "Confirm"}) {
    ModalContent m = new ModalContent()
      ..headline = headline
      ..message = message
      ..ok="yes"
      ..cancel="no";
    return _modal(m);
  }

  Future<Object> input(String message, {String headline: "Input value"}) {
    ModalContent m = new ModalContent()
      ..headline = headline
      ..message = message
      ..input = "text"
      ..ok="ok"
      ..cancel="cancel";
    return _modal(m);
  }

  Future _modal(ModalContent mc) {
    StreamController streamController = new StreamController();
    mc._stream = streamController;
    modalWindows[mc.id] = mc;
    return streamController.stream.first;
  }

  void closeModal(String id, bool closingResult) {
    ModalContent mc = modalWindows[id];
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

class ModalContent {
  String id = ui.uid('modal-');
  String headline;
  String message;
  String ok;
  String cancel;
  String input;
  var value;
  StreamController _stream;
}