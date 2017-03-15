// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

import '../example_app.dart';
import '../example_buttons_renderer.dart';

@Component(
    selector: 'cookbook-table',
    templateUrl: 'cookbook_table.html',
    directives: const [ExampleButtonsRenderer]
)
class CookbookTable {

  ExampleApp app;

  String search = null;

  bool bordersOn = false;
  bool linesOn = false;
  bool stripesOn = false;
  bool activeOn = false;

  CookbookTable(this.app);

  ngOnInit() {
    loadMore();
  }

  Iterable get list {
    if (search == null) return app.list;
    return app.list.where(containsSearch);
  }

  bool containsSearch(Map<String,Object> row) {
    return row["name"].toString().contains(search) || row["email"].toString().contains(search);
  }

  void loadMore() {
    app.loadMore();
  }


}
