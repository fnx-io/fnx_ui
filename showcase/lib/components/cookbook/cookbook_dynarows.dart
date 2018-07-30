// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui_showcase/app_config.dart';

@Component(
  selector: 'cookbook-dynarows',
  templateUrl: 'cookbook_dynarows.html',
  directives: [
    fnxUiDirectives,
    coreDirectives,
    formDirectives,
    appDirectives
  ],
)
class CookbookDynarows {

  List rows = [
    {"name": "One"},
    {"name": "Two"}
  ];

  void addRow() {
    rows.add({});
  }

  void removeRow(var element) {
    rows.remove(element);
  }

}
