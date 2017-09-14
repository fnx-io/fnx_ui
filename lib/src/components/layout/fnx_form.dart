// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular2/core.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:fnx_ui/src/validator.dart';
import 'package:logging/logging.dart';

typedef String formValidatorFunction();

@Component(
  selector: 'fnx-form',
  templateUrl: 'fnx_form.html',
  providers: const [
    const Provider(FnxValidatorComponent, useExisting: FnxForm, multi: false),
  ],
)
class FnxForm extends FnxValidatorComponent implements OnInit, OnDestroy {

  final Logger log = new Logger("FnxForm");

  ///
  /// Use to disable form (no submit event will be generated).
  /// Example:
  /// 
  ///     <fnx-form [disabled]="rest.working"></fnx-form>
  ///
  @Input()
  bool disabled = false;

  @Input()
  bool readonly = false;

  FnxForm() : super(null);
  
  @override
  bool get required => false;

  @Output()
  final EventEmitter<Event> submit = new EventEmitter<Event>();

  String id = ui.uid('form-');

  List<formValidatorFunction> _validators = [];

  List<String> errorMessages = [];

  /// Handles submitting the underlying form event.
  /// Only propagates the submit event when this form is valid.
  /// Forces validation of all components inside this form.
  void submitForm(Event event) {
    print(event);
    if (event != null) {
      event.preventDefault();
      event.stopPropagation();
    }
    if (disabled) return;

    markAsTouched();
    errorMessages = [];

    for (formValidatorFunction f in _validators) {
      String error = f();
      if (error != null) {
        errorMessages.add(error);
      }
    }
    
    if (isValid() && errorMessages.isEmpty) {
      submit.emit(event);
      
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
}