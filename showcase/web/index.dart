// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:fnx_ui/errors.dart';
import 'package:logging/logging.dart';

import 'example_app.dart';
import 'example_buttons_renderer.dart';

Future<Null> main() async {

  /*
    Intl.defaultLocale = 'cs_CZ';
    await initializeMessages('cs_CZ');
    await initializeDateFormatting("cs_CZ", null);
  */

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

  /*
  Logger r = new Logger("admin.dart");
  r.info("================================================================");
  r.info(" Starting NanoEnvi admin:");
  r.info("   - apiRoot: ${apiRoot}");
  r.info("   - build: ${fnxConfigMeta()["timestamp"]}");
  r.info("================================================================");
  */

  // START!
  bootstrap(ExampleApp, [
    ROUTER_PROVIDERS,
    [ExampleButtonsRenderer],
    provide(LocationStrategy, useClass: HashLocationStrategy),
    provide(ExceptionHandler, useValue: new FnxExceptionHandler())
  ]);

}
