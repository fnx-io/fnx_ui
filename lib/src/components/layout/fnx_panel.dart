// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:fnx_ui/src/validator.dart';
import 'package:logging/logging.dart';

///
/// Nice "fieldset". It should have a header, defined with attribute 'header'. Like this:
///
///       <fnx-panel>
///           <h3 header>Address</h1>
///           <p header>Please fill your address</p>
///           <div>Panel content ...</div>
///       </fnx-panel>
///
@Component(
  selector: 'fnx-panel',
  templateUrl: 'fnx_panel.html',
  styles: const [":host {display: block;}"],
  preserveWhitespace: false,
  providers: const [
    const Provider(FnxValidatorComponent, useExisting: FnxPanel, multi: false),
  ],
)
class FnxPanel extends FnxValidatorComponent implements OnInit, OnDestroy {

  final Logger log = new Logger("FnxPanel");

  ///
  /// Input. Can by collapsed or expanded by user. Default = false = always open.
  ///
  @Input()
  bool closable = false;

  @Input()
  bool open = null;

  String id = ui.uid('panel-');

  FnxPanel(@SkipSelf() @Optional() FnxValidatorComponent parent) : super(parent);

  @override
  ngOnInit() {
    super.ngOnInit();
    if (closable == null) closable = false;
    if (open == null) {
      open = !closable;
    }
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
