// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:fnx_ui_demo/component.dart';
import 'package:fnx_ui_demo/data.dart';

@Component(
  selector: 'demo-app',
  templateUrl: 'app.html',
)
@RouteConfig(const [
  const Route(path: '/fnx-alert', name: 'Alert', component: AlertExample),
  const Route(path: '/fnx-app', name: 'App', component: AppExample),
  const Route(path: '/fnx-autocomplete', name: 'Autocomplete', component: AutocompleteExample),
  const Route(path: '/fnx-cc', name: 'Cc', component: CcExample),
  const Route(path: '/fnx-check', name: 'Check', component: CheckExample),
  const Route(path: '/fnx-date', name: 'Date', component: DateExample),
  const Route(path: '/fnx-double', name: 'Double', component: DoubleExample),
  const Route(path: '/fnx-file', name: 'File', component: FileExample),
  const Route(path: '/fnx-form', name: 'Form', component: FormExample),
  const Route(path: '/fnx-form-errors', name: 'FormErrors', component: FormErrorsExample),
  const Route(path: '/fnx-formatted-double', name: 'FormattedDouble', component: FormattedDoubleExample),
  const Route(path: '/fnx-icon', name: 'Icon', component: IconExample),
  const Route(path: '/fnx-image-crop', name: 'ImageCrop', component: ImageCropExample),
  const Route(path: '/fnx-input', name: 'Input', component: InputExample),
  const Route(path: '/fnx-int', name: 'Int', component: IntExample),
  const Route(path: '/fnx-layout-sidebar', name: 'LayoutSidebar', component: LayoutSidebarExample),
  const Route(path: '/fnx-modal', name: 'Modal', component: ModalExample),
  const Route(path: '/fnx-option', name: 'Option', component: OptionExample),
  const Route(path: '/fnx-panel', name: 'Panel', component: PanelExample),
  const Route(path: '/fnx-panel-small', name: 'PanelSmall', component: PanelSmallExample),
  const Route(path: '/fnx-scroll-panel', name: 'ScrollPanel', component: ScrollPanelExample),
  const Route(path: '/fnx-select', name: 'Select', component: SelectExample),
  const Route(path: '/fnx-submit-bar', name: 'SubmitBar', component: SubmitBarExample),
  const Route(path: '/fnx-tab', name: 'Tab', component: TabExample),
  const Route(path: '/fnx-tabs', name: 'Tabs', component: TabsExample),
  const Route(path: '/fnx-text', name: 'Text', component: TextExample),
  const Route(path: '/fnx-textarea', name: 'Textarea', component: TextareaExample),
  const Route(path: '/fnx-wysiwyg-poor', name: 'WysiwygPoor', component: WysiwygPoorExample),
  const Route(path: '/fnx-wysiwyg-rich', name: 'WysiwygRich', component: WysiwygRichExample),
])
class DemoApp {
  List components = componentsData;

  String filter = '';

  /// Determines if component by [tagName] is filtered and should be shown.
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
            false) ||
        mightFilterNgModel(component.ngModelCompatible, filterValue)) {
      return true;
    }

    return false;
  }

  /// Transforms [text] for filtering.
  /// If [null] is given, returns null.
  String transformText(final String text) {
    return text?.toLowerCase()?.replaceAll(new RegExp(r'[.,\-_?! ]', caseSensitive: false), r'');
  }

  /// If [ngModelCompatible] is [true], this determines if [filterValue] might be about ngModel.
  bool mightFilterNgModel(bool ngModelCompatible, String filterValue) {
    if (ngModelCompatible == null || filterValue == null) return false;

    if (ngModelCompatible == true && 'ngmodel'.contains(filterValue)) return true;

    return false;
  }
}
