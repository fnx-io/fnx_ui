// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:logging/logging.dart';

import 'package:fnx_ui_documentation/main_app.dart';
import 'package:fnx_ui/errors.dart';

void main() {

  // logování
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    String message = '[${rec.level.name}]:'.padRight(8) + '${rec.loggerName}: ${rec.message}';
    if (rec.level >= Level.SEVERE) {
      window.console.error(message);
    } else {
      print(message);
    }
  });

  // info o startu
  Logger r = new Logger("index.dart");
  r.info("Starting bootstrap(MainApp)");

  // START!
  bootstrap(MainApp, [
      ROUTER_PROVIDERS,
      provide(LocationStrategy, useClass: HashLocationStrategy),
      provide(ExceptionHandler, useValue: new FnxExceptionHandler())
  ]);

}
