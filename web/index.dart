// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library my_project.web.index;

import 'package:fnx_ui/fnx_ui.dart';

import 'package:fnx_ui/ui/fnx_button.dart';

import 'package:fnx_ui/ui/fnx_icon.dart';
import 'package:fnx_ui/ui/fnx_fieldset.dart';
import 'package:fnx_ui/rest/fnx_validator.dart';
import 'package:fnx_ui/ui/fnx_field.dart';
import 'package:fnx_ui/ui/fnx_submit_bar.dart';


import 'package:fnx_ui/app/fnx_app.dart';

import 'package:fnx_ui/rest/fnx_rest_view.dart';

import 'package:polymer/polymer.dart';

import 'package:fnx_router/fnx_router.dart';
import 'package:logging/logging.dart';
import 'package:polymer_elements/iron_pages.dart';

import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_tooltip.dart';
import 'package:polymer_elements/paper_checkbox.dart';
import 'package:polymer_elements/paper_radio_button.dart';
import 'package:polymer_elements/paper_radio_group.dart';

import 'package:polymer_elements/paper_input_container.dart';

main() async {

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.loggerName}: ${rec.message} (${rec.time})');
  });

  print("Starting Polymer ...");
  await initPolymer();
  print ("... Polymer started.");

}
