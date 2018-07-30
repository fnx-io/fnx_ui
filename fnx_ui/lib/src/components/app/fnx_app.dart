// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/errors.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/components/layout/fnx_form.dart';
import 'package:fnx_ui/src/components/modal/fnx_modal.dart';
import 'package:fnx_ui/src/util/global_messages.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:logging/logging.dart';

///
/// Provides usefull methods for toast, simple 'alert' style dialogs, manages exceptions.
/// Wrap your whole app into this component and inject it into your components.
///
/// Demo: [http://demo.fnx.io/fnx_ui/ng2/#/Modals](http://demo.fnx.io/fnx_ui/ng2/#/Modals)
///
@Component(
  selector: 'fnx-app',
  templateUrl: 'fnx_app.html',
  preserveWhitespace: false,
  directives: [
    coreDirectives,
    formDirectives,
    FnxForm,
    FnxModal,
    FnxInput,
    FnxText
  ],
  visibility: Visibility.all,
)
class FnxApp implements OnInit {
  final Logger log = new Logger("FnxApp");

  Map<String, _ModalContent> modalWindows = {};
  List<_ToastContent> toasts = [];

  ChangeDetectorRef _changeDetector;

  FnxApp(@Optional() ExceptionHandler ex, this._changeDetector) {
    if (ex == null) {
      log.warning("There is no exception handler configured");
    }
    if (ex is! FnxExceptionHandler) {
      log.warning(
          "Configured exception handler is not FnxExceptionHandler, fnx_ui won't be able to show nice errors.\nConsider: provide(ExceptionHandler, useValue: new FnxExceptionHandler())");
    } else {
      (ex as FnxExceptionHandler).setShowErrorCallback(showError);
    }
  }

  ngOnInit() {
    log.fine("App started");
  }

  // TOASTS
  ///
  /// Shows simple 'flash message': 'User created', 'Record deleted', etc.
  ///
  void toast(String text, {Duration duration: const Duration(milliseconds: 4000), String cssClass: ""}) {
    _ToastContent t = new _ToastContent()
      ..cssClass = cssClass
      ..message = text;
    toasts.add(t);
    new Future.delayed(duration).then((_) {
      t.hide = true;
      _changeDetector.detectChanges();
    });
    new Future.delayed(duration + const Duration(seconds: 1)).then((_) {
      if (toasts.firstWhere((_ToastContent t) => t.hide == false, orElse: () => null) == null) {
        toasts.clear();
      }
    });
    _changeDetector.detectChanges();
  }

  // Exception handling

  FnxError errorToShow;

  void showError(FnxError error) {
    log.info("Showing error $error on UI");
    this.errorToShow = error;
    _changeDetector.detectChanges();
  }

  // MODAL WINDOWS
  ///
  /// Plain old window.alert style dialog. Nonblocking.
  ///
  Future alert(String message, {String headline: null}) {
    headline = headline ?? GlobalMessages.appDefaultAlertHeadline();
    _ModalContent m = new _ModalContent()
      ..headline = headline
      ..message = message
      ..ok = GlobalMessages.ok();
    return _modal(m);
  }

  ///
  /// Plain old window.confirm style dialog. Nonblocking.
  ///
  Future<bool> confirm(String message, {String headline: null}) {
    headline = headline ?? GlobalMessages.appDefaultConfirmHeadline();
    _ModalContent m = new _ModalContent()
      ..headline = headline
      ..message = message
      ..ok = GlobalMessages.yes()
      ..cancel = GlobalMessages.no();
    return _modal(m);
  }

  ///
  /// Plain old window.input style dialog. Nonblocking.
  ///
  Future<Object> input(String message, {String headline: null, String prefilledValue: null}) {
    headline = headline ?? GlobalMessages.appDefaultInputHeadline();
    _ModalContent m = new _ModalContent()
      ..headline = headline
      ..message = message
      ..input = "text"
      ..ok = GlobalMessages.ok()
      ..cancel = GlobalMessages.cancel()
      ..value = prefilledValue;
    return _modal(m);
  }

  Future _modal(_ModalContent mc) {
    Completer c = new Completer();
    mc._completer = c;
    modalWindows[mc.id] = mc;
    _changeDetector.detectChanges();
    return c.future;
  }

  void closeModal(String id, bool closingResult) {
    _ModalContent mc = modalWindows[id];
    if (mc == null) return;
    modalWindows.remove(id);

    if (mc.input != null) {
      // input mode
      if (closingResult) {
        // ok
        mc._completer.complete(mc.value);
      } else {
        // cancel
        mc._completer.complete(null);
      }
    } else {
      // common alert
      mc._completer.complete(closingResult);
    }
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
  Completer _completer;
}

class _ToastContent {
  String message;
  bool hide = false;
  String cssClass = "";
}
