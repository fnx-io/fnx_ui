// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import '../example_app.dart';
import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/components/modal/fnx_modal.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import '../example_buttons_renderer.dart';

@Component(
    selector: 'cookbook-master-detail',
    templateUrl: 'cookbook_master_detail.html',
    directives: const [ExampleButtonsRenderer]
)
class CookbookMasterDetail {

  ExampleApp exApp;
  FnxApp app;

  var selected = null;

  CookbookMasterDetail(this.exApp, this.app);

  ngOnInit() {
    loadMore();
  }

  List get list => exApp.list;

  void loadMore() {
    exApp.loadMore();
  }

  void todo() {
    app.alert("This function is not implemented. Why would be, this is a master-detail example", headline: "This is not a real app");
  }


}
