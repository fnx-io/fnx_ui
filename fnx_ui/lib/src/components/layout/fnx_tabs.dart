// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:fnx_ui/src/validator.dart';
import 'package:logging/logging.dart';

@Component(
  selector: 'fnx-tabs',
  template: '''
    <div class="menu--tabs">
        <a class="item" *ngFor="let tab of tabs"
        (click)="tab.selectTab()"
        [class.tab--active]="selectedId == tab.id"
        [innerHtml]="tab.title"></a>
        <span style="flex-grow: 4; flex-shrink: 1" *ngIf="left"></span>
    </div>
    <div class="relative">
        <ng-content></ng-content>
    </div>
  ''',
  preserveWhitespace: false,
  providers: const [
    const Provider(FnxValidatorComponent, useExisting: FnxTabs, multi: false),
  ],
  visibility: Visibility.all,
  directives: [
    coreDirectives,
    formDirectives,
  ],
)
class FnxTabs extends FnxValidatorComponent implements OnInit, OnDestroy {
  final Logger log = new Logger("FnxTabs");

  String id = ui.uid('tabs-');
  String selectedId = null;

  @Input()
  bool left = false;

  List<FnxTab> tabs = [];

  FnxTabs(@SkipSelf() @Optional() FnxValidatorComponent parent) : super(parent);

  void deregister(FnxTab fnxTab) {
    tabs.remove(fnxTab);
    if (fnxTab.id == selectedId) {
      // trouble!
      if (tabs.isNotEmpty) {
        tabs[0].selectTab();
      } else {
        selectedId = null;
      }
    }
  }

  void register(FnxTab fnxTab) {
    tabs.add(fnxTab);
    if (selectedId == null) fnxTab.selectTab();
  }

  @override
  bool hasValidValue() => true;

  @override
  bool get readonly => false;

  @override
  bool get required => false;

  @override
  bool get disabled => false;
}

@Component(
    selector: 'fnx-tab',
    template: '''
  <div *ngIf="tabParent.selectedId == id">
    <ng-content></ng-content>
  </div>
  ''',
    styles: const [":host { display: block; } "],
    preserveWhitespace: false,
  providers: const [
    const Provider(FnxValidatorComponent, useExisting: FnxTab, multi: false),
  ],
  directives: [
    coreDirectives,
    formDirectives,
  ],
)
class FnxTab extends FnxValidatorComponent implements OnInit, OnDestroy {
  @Input()
  String title;

  String id = ui.uid('tab-');

  FnxTabs tabParent;

  FnxTab(this.tabParent, @SkipSelf() @Optional() FnxValidatorComponent parent) : super(parent);

  StreamController<bool> _select = new StreamController();
  @Output()
  Stream<bool> get select => _select.stream;

  void selectTab() {
    if (tabParent == null) return;
    tabParent.selectedId = id;
    _select.add(true);
  }

  @override
  ngOnInit() {
    super.ngOnInit();
    if (title == null) throw "Title attribute is mandatory!";
    tabParent.register(this);
  }

  @override
  ngOnDestroy() {
    super.ngOnDestroy();
    tabParent.deregister(this);
  }

  @override
  bool hasValidValue() => true;

  @override
  bool get readonly => false;

  @override
  bool get required => false;

  @override
  bool get disabled => false;
}
