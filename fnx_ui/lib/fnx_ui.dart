// Copyright (c) 2016, Tomucha. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// Support for doing something awesome.
///
/// More dartdocs go here.
library fnx_ui;

import 'src/components/fnx_tooltip.dart';
import 'src/components/app/fnx_app.dart';
import 'src/components/app/fnx_cc.dart';
import 'src/components/auto_focus.dart';
import 'src/components/date/fnx_date.dart';
import 'src/components/fnx_form_errors.dart';
import 'src/components/fnx_icon.dart';
import 'src/components/fnx_reorder.dart';
import 'src/components/fnx_submit_bar.dart';
import 'src/components/image/fnx_image_crop.dart';
import 'src/components/input/fnx_check.dart';
import 'src/components/input/fnx_double.dart';
import 'src/components/input/fnx_file.dart';
import 'src/components/input/fnx_formatted_double.dart';
import 'src/components/input/fnx_input.dart';
import 'src/components/input/fnx_int.dart';
import 'src/components/input/fnx_text.dart';
import 'src/components/input/fnx_textarea.dart';
import 'src/components/input/fnx_wysiwyg_poor.dart';
import 'src/components/input/fnx_wysiwyg_rich.dart';
import 'src/components/layout/fnx_alert.dart';
import 'src/components/layout/fnx_form.dart';
import 'src/components/layout/fnx_layout_sidebar.dart';
import 'src/components/layout/fnx_panel.dart';
import 'src/components/layout/fnx_panel_small.dart';
import 'src/components/layout/fnx_scroll_panel.dart';
import 'src/components/layout/fnx_tabs.dart';
import 'src/components/modal/fnx_modal.dart';
import 'src/components/select/fnx_autocomplete.dart';
import 'src/components/select/fnx_select.dart';

export 'src/components/app/fnx_app.dart';
export 'src/components/app/fnx_cc.dart';
export 'src/components/auto_focus.dart';
export 'src/components/date/fnx_date.dart';
export 'src/components/fnx_form_errors.dart';
export 'src/components/fnx_icon.dart';
export 'src/components/fnx_reorder.dart';
export 'src/components/fnx_submit_bar.dart';
export 'src/components/image/fnx_image_crop.dart';
export 'src/components/input/fnx_check.dart';
export 'src/components/input/fnx_double.dart';
export 'src/components/input/fnx_file.dart';
export 'src/components/input/fnx_formatted_double.dart';
export 'src/components/input/fnx_input.dart';
export 'src/components/input/fnx_int.dart';
export 'src/components/input/fnx_text.dart';
export 'src/components/input/fnx_textarea.dart';
export 'src/components/input/fnx_wysiwyg_poor.dart';
export 'src/components/input/fnx_wysiwyg_rich.dart';
export 'src/components/layout/fnx_alert.dart';
export 'src/components/layout/fnx_form.dart';
export 'src/components/layout/fnx_layout_sidebar.dart';
export 'src/components/layout/fnx_panel.dart';
export 'src/components/layout/fnx_panel_small.dart';
export 'src/components/layout/fnx_scroll_panel.dart';
export 'src/components/layout/fnx_tabs.dart';
export 'src/components/modal/fnx_modal.dart';
export 'src/components/select/fnx_autocomplete.dart';
export 'src/components/select/fnx_select.dart';
export 'src/components/fnx_tooltip.dart';

const List<Type> fnxUiDirectives = const [
  FnxApp,
  FnxPanel,
  FnxPanelSmall,
  FnxModal,
  FnxLayoutSidebar,
  FnxScrollPanel,
  FnxForm,
  FnxCheck,
  FnxText,
  FnxInt,
  FnxDouble,
  FnxFormattedDouble,
  FnxFile,
  FnxTextarea,
  FnxAlert,
  FnxTabs,
  FnxTab,
  FnxImageCrop,
  FnxFormErrors,
  FnxWysiwygPoor,
  FnxWysiwygRich,
  AutoFocus,
  FnxAutocomplete,
  FnxReorderContainer,
  FnxReorderItem,
  FnxCC,
  FnxInput,
  FnxSelect,
  FnxOption,
  FnxDate,
  FnxDatePicker,
  FnxIcon,
  FnxSubmitBar,
  FnxTooltip
];
