// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui_showcase/app_config.dart';
import 'package:fnx_ui_showcase/example_app.dart';

@Component(
  selector: 'cookbook-table',
  templateUrl: 'cookbook_table.html',
  directives: [
    fnxUiDirectives,
    coreDirectives,
    formDirectives,
    appDirectives
  ],
)
class CookbookTable {

  ExampleApp app;

  String? search = null;

  bool bordersOn = false;
  bool linesOn = false;
  bool stripesOn = false;
  bool activeOn = true;

  CookbookTable(this.app);

  Map? selectedRow = null;

  ngOnInit() {
    loadMore();
  }

  Iterable get list {
    if (search == null) return app.list;
    return app.list.where(containsSearch);
  }

  bool containsSearch(Map<String,Object> row) {
    return row["name"].toString().contains(search!) || row["email"].toString().contains(search!);
  }

  void loadMore() {
    app.loadMore();
  }


}
