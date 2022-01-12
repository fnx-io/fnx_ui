// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:fnx_ui/src/validator.dart';
import 'package:logging/logging.dart';

typedef String? formValidatorFunction();

@Component(
    selector: 'fnx-form',
    templateUrl: 'fnx_form.html',
    providers: const [
      const Provider(FnxValidatorComponent, useExisting: FnxForm),
    ],
    visibility: Visibility.all)
class FnxForm extends FnxValidatorComponent implements OnInit, OnDestroy {
  final Logger log = new Logger("FnxForm");

  ///
  /// Use to disable form (no submit event will be generated).
  /// Example:
  ///
  ///     <fnx-form [disabled]="rest.working"></fnx-form>
  ///
  @Input()
  @override
  bool disabled = false;

  @Input()
  bool readonly = false;

  FnxForm() : super(null);

  @override
  bool get required => false;

  StreamController<Event> _submit = new StreamController();
  @Output()
  Stream<Event> get submit => _submit.stream;

  StreamController<BeforeFormSubmitEvent> _beforeSubmit = new StreamController();
  @Output()
  Stream<BeforeFormSubmitEvent> get beforeSubmit => _beforeSubmit.stream;

  String id = ui.uid('form-');

  List<formValidatorFunction> _validators = [];

  List<String> errorMessages = [];

  /// Handles submitting the underlying form event.
  /// Only propagates the submit event when this form is valid.
  /// Forces validation of all components inside this form.
  void submitForm(var event) {
    _beforeSubmit.add(new BeforeFormSubmitEvent());

    if (event != null) {
      try {
        event.preventDefault();
      } catch (e) {}
      try {
        event.stopPropagation();
      } catch (e) {}
    }
    if (disabled) return;

    markAsTouched();
    errorMessages = [];

    for (formValidatorFunction f in _validators) {
      String? error = f();
      if (error != null) {
        errorMessages.add(error);
      }
    }

    if (isValid() && errorMessages.isEmpty) {
      _submit.add(new Event("submit"));
    } else {
      // there are some complex validation errors
    }
  }

  @override
  bool hasValidValue() => true;

  void addValidator(formValidatorFunction f) {
    _validators.add(f);
  }

  void removeValidator(formValidatorFunction f) {
    _validators.remove(f);
  }

  bool get isReadonly => readonly;
}

class BeforeFormSubmitEvent {}
