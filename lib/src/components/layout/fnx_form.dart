// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:html';
import 'package:fnx_ui/src/validator.dart';
import 'dart:async';

@Component(
  selector: 'fnx-form',
  template: '<form (submit)="markAsTouched()"><ng-content></ng-content></form>'
)
class FnxForm extends FnxValidatorComponent {

  final Logger log = new Logger("FnxForm");

  String id = ui.uid('form-');

  // TODO submit emiter, pokud je form submit a ja jsem valid

  @override
  bool hasValidValue() {
    return true;
  }

}
