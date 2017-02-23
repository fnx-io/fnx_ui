// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:html';

///
/// Creates standardized (very visible) box with warning, error, important notice etc.
///
/// Demo: [http://demo.fnx.io/fnx_ui/ng2/#/Panels](http://demo.fnx.io/fnx_ui/ng2/#/Panels)
///
@Component(
  selector: 'fnx-alert',
  templateUrl: 'fnx_alert.html',
  preserveWhitespace: false
)
class FnxAlert implements OnInit {

  final Logger log = new Logger("FnxAlert");

  static const POSSIBLE_TYPES = const ["info","warning","error","success"];

  ///
  /// Input. One of possible predefined types:"info","warning","error","success"
  ///
  @Input()
  String type;

  ///
  /// Input. Displays small cross icon which hides the message.
  ///
  @Input()
  bool closable = true;

  ///
  /// Input. Use to customize colors: bg--red text--yellow.
  ///
  @Input()
  String colorClass;

  ///
  /// Input. Use to customize icon. Possible values are icon names from material design icons.
  ///
  @Input()
  String icon;

  bool get isClosable => closable != null;

  bool open = true;

  String id = ui.uid('alert-');

  @override
  ngOnInit() {
    if (type != null && !POSSIBLE_TYPES.contains(type)) {
      throw "'type' atrribute allows you to use predefined alerts, however the only possible types are $POSSIBLE_TYPES";
    }

    if (icon == null && type != null) {
      switch (type) {
        case "info": icon = "info"; break;
        case "warning": icon = "warning"; break;
        case "error": icon = "error"; break;
        case "success": icon = "check"; break;
      }
    }

    if (colorClass == null && type != null) {
      switch (type) {
        case "info": colorClass = "bg--white"; break;
        case "warning": colorClass = "bg--fnx"; break;
        case "error": colorClass = "bg--red"; break;
        case "success": colorClass = "bg--green"; break;
      }
    }

    if (icon == null) icon = "info";
    if (colorClass == null) colorClass = "bg--info";

  }

  void close() {
    open = false;
  }

}
