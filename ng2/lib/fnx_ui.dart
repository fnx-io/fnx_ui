// Copyright (c) 2016, Tomucha. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// Support for doing something awesome.
///
/// More dartdocs go here.
library fnx_ui;

import 'src/components/app/fnx_app.dart';
import 'src/components/input/fnx_input.dart';
import 'src/components/input/fnx_text.dart';
import 'src/components/select/fnx_select.dart';
import 'src/components/date/fnx_date.dart';
import 'src/components/panel/fnx_panel.dart';
import 'src/components/fnx_icon.dart';

export 'src/components/app/fnx_app.dart';
export 'src/components/input/fnx_input.dart';
export 'src/components/input/fnx_text.dart';
export 'src/components/select/fnx_select.dart';
export 'src/components/date/fnx_date.dart';
export 'src/components/panel/fnx_panel.dart';
export 'src/components/fnx_icon.dart';

const List FNX_UI_COMPONENTS = const [FnxApp,
                                      FnxPanel,
                                      FNX_INPUT_DIRECTIVES,
                                      FNX_INPUT_TEXT_DIRECTIVES,
                                      FNX_SELECT_DIRECTIVES,
                                      FNX_DATE_DIRECTIVES,
                                      FNX_ICON_DIRECTIVES];
