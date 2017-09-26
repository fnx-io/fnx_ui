// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/validator.dart';

///
/// Nice "fieldset", smaller and less contrasting then fnx-panel.. It should have a header, defined with attribute 'header'. Like this:
///
///      <fnx-panel-small>
///          <h1 header>Address</h1>
///          <p header>Please fill your address</p>
///          <div>Panel content ...</div>
///      </fnx-panel-small>
///
@Component(
  selector: 'fnx-panel-small',
  templateUrl: 'fnx_panel_small.html',
  styles: const [":host {display: block;}"],
  preserveWhitespace: false,
  providers: const [
    const Provider(FnxValidatorComponent, useExisting: FnxPanelSmall, multi: false),
  ],
)
class FnxPanelSmall extends FnxPanel implements OnInit, OnDestroy {
  FnxPanelSmall(@SkipSelf() @Optional() FnxValidatorComponent parent) : super(parent);

  ///
  /// Input. Can by collapsed or expanded by user. Default = false = always open.
  ///
  @Input()
  bool closable = false;

  @Input()
  bool open = null;

  @override
  bool get disabled => false;
}
