// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import 'package:fnx_ui_showcase/app_config.dart';
import 'package:fnx_ui_showcase/example_app.dart';

@Component(
  selector: 'cookbook-master-detail',
  templateUrl: 'cookbook_master_detail.html',
  directives: [
    fnxUiDirectives,
    coreDirectives,
    formDirectives,
    appDirectives
  ],
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
