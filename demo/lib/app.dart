// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:fnx_ui_demo/src/example/modal.dart';
import 'package:fnx_ui_demo/src/example/panel.dart';
import 'package:fnx_ui_demo/src/example/tab.dart';
import 'package:fnx_ui_demo/data.dart';

@Component(
  selector: 'demo-app',
  templateUrl: 'app.html',
)
@RouteConfig(const [
  const Route(path: '/fnx-modal', name: 'Modal', component: ModalExample),
  const Route(path: '/fnx-panel', name: 'Panel', component: PanelExample),
  const Route(path: '/fnx-tab', name: 'Tab', component: TabExample),
])
class DemoApp {
  List components = componentsData;

  String filter = '';

  bool isFiltered(String tagName) {
    String filterValue = transformText(filter);

    ComponentModel component =
        components.firstWhere((ComponentModel component) => component.tag == tagName, orElse: ([_]) => null);

    if (component == null) {
      return false;
    }

    if (filterValue == null ||
        (transformText(component.tag)?.contains(filterValue) ?? false) ||
        (transformText(component.description)?.contains(filterValue) ?? false) ||
        (transformText(component.className)?.contains(filterValue) ?? false) ||
        (component.ios?.any((IoModel input) => transformText(input.name)?.contains(filterValue) ?? false) ??
            false) ||
        (component.ios?.any((IoModel input) => transformText(input.type)?.contains(filterValue) ?? false) ??
            false)) {
      return true;
    }

    return false;
  }

  /// Transforms [text] for filtering.
  /// If [null] is given, returns null.
  String transformText(final String text) {
    return text?.toLowerCase()?.replaceAll(new RegExp(r'[.,\-_?! ]', caseSensitive: false), r'');
  }
}
