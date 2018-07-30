// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

//import 'dart:async';
//import 'package:fnx_ui/errors.dart';

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:fnx_ui/i18n/fnx_messages_all.dart';
import 'package:fnx_ui_showcase/example_app.template.dart' as ng;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

import 'index.template.dart' as self;

@GenerateInjector(
  routerProvidersHash, // You can use routerProviders in production
)
final InjectorFactory injector = self.injector$Injector;

Future main() async {

  Intl.defaultLocale = 'cs_CZ';
  await initializeMessages('cs_CZ');
  await initializeDateFormatting("cs_CZ", null);

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

  Logger r = new Logger("admin.dart");
  r.info("================================================================");
  r.info(" Starting showcase:");
  r.info("================================================================");

  // START!
  runApp(ng.ExampleAppNgFactory, createInjector: injector);

}
