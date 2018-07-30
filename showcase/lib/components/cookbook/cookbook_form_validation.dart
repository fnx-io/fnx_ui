// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import 'package:fnx_ui_showcase/app_config.dart';

@Component(
  selector: 'cookbook-form-validation',
  templateUrl: 'cookbook_form_validation.html',
  directives: [
    fnxUiDirectives,
    coreDirectives,
    formDirectives,
    appDirectives
  ],
)
class CookbookFormValidation implements OnInit {

  Map record = { };

  FnxApp app;

  @ViewChild("validatedForm")
  FnxForm form;

  CookbookFormValidation(this.app);

  void postRecord() {
    app.toast("Done!");
  }

  @override
  ngOnInit() {
    form.addValidator(customValidation);
  }

  String customValidation() {
    if (record['one'] == null || record['two'] == null) {
      return "Please fill both values";
    }
    if (record['one'] != record['two']) {
      return "Both values must be the same";
    }
    return null;
  }

}
