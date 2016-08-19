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
  templateUrl: 'fnx_form.html'
)
class FnxForm extends FnxValidatorComponent {

  final Logger log = new Logger("FnxForm");

  final EventEmitter<Event> submit = new EventEmitter<Event>();

  String id = ui.uid('form-');

  /// Handles submitting the underlying form event.
  /// Only propagates the submit event when this form is valid.
  /// Forces validation of all components inside this form.
  void submitForm(Event event) {
    markAsTouched();
    if (event != null) {
      event.preventDefault();
      event.stopPropagation();
    }

    if (isValid()) {
      submit.emit(event);
    }
  }

  @override
  bool hasValidValue() {
    return true;
  }

}
