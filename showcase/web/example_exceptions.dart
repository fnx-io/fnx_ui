// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:fnx_ui/errors.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:logging/logging.dart';

import 'example_buttons_renderer.dart';

@Component(
    selector: 'example-exceptions',
    templateUrl: 'example_exceptions.html',
    directives: const [ExampleButtonsRenderer]
)
class ExampleExceptions {

  FnxApp app;

  final Logger log = new Logger("ExampleExceptions");

  bool customModalVisible = false;

  ExampleExceptions(ExceptionHandler handler, this.app) {
    // register custom exception handler
    (handler as FnxExceptionHandler).registerErrorProcessor(int, processIntException);
    (handler as FnxExceptionHandler).registerErrorProcessor(CustomException, processCustomException);
  }

  void stringException() {
    throw "Oopsie";
  }

  void intException() {
    throw 42;
  }

  void customException() {
    throw new CustomException();
  }

  ///
  /// Custom exception handler.
  ///
  FnxError processIntException(Object exception, StackTrace stacktrace) {
    int code = (exception as int);
    return new FnxError("This is error code ${code}",
        headline: "Custom headline",
        details: ["code = ${code}", "2*code = ${2*code}"]);
  }

  ///
  /// Custom exception handler.
  ///
  FnxError processCustomException(Object exception, StackTrace stacktrace) {
    app.toast("Custom exception, yay!");
    return null;
  }

}

class CustomException {

  CustomException();

}