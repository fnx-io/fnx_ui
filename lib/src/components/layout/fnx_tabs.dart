// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:html';

@Component(
  selector: 'fnx-tabs',
  template: '''
    <div class="menu--tabs">
        <a class="item" *ngFor="let tab of tabs"
        (click)="selectedId = tab.id"
        [class.tab--active]="selectedId == tab.id"
        >{{tab.title}}</a>
    </div>
    <div class="relative">
        <ng-content></ng-content>
    </div>
  ''',
  preserveWhitespace: false
)
class FnxTabs implements OnInit {

  final Logger log = new Logger("FnxTabs");

  String id = ui.uid('tabs-');
  String selectedId = null;

  List<FnxTab> tabs = [];

  @override
  ngOnInit() {
  }

  void deregister(FnxTab fnxTab) {
    tabs.remove(fnxTab);
    if (fnxTab.id == selectedId) {
      // trouble!
      if (tabs.isNotEmpty) {
        selectedId = tabs[0].id;
      } else {
        selectedId = null;
      }
    }
  }

  void register(FnxTab fnxTab) {
    tabs.add(fnxTab);
    if (selectedId == null) selectedId = fnxTab.id;
  }

}

@Component(
  selector: 'fnx-tab',
  template: '''
  <div *ngIf="parent.selectedId == id">
    <ng-content></ng-content>
  </div>
  ''',
  styles: const [":host { display: block; } "],
  preserveWhitespace: false
)
class FnxTab implements OnInit, OnDestroy {

  @Input()
  String title;

  String id = ui.uid('tab-');

  FnxTabs parent;

  FnxTab(this.parent);

  @override
  ngOnInit() {
    if (title == null) throw "Title attribute is mandatory!";
    parent.register(this);
  }


  @override
  ngOnDestroy() {
    parent.deregister(this);
  }
}
