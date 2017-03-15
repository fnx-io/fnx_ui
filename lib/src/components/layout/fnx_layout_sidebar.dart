// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:logging/logging.dart';

@Component(
  selector: 'fnx-layout-sidebar',
  templateUrl: 'fnx_layout_sidebar.html',
  styles: const [
    ":host {display: block;}",
    ":host .layout__sidebar > *:only-child { position: absolute; top:0; left:0; bottom:0; right:0; }",
    ":host .layout__main > *:only-child { position: absolute; top:0; left:0; bottom:0; right:0; }"
  ],
  preserveWhitespace: false
)
class FnxLayoutSidebar implements OnInit {

  final Logger log = new Logger("FnxLayoutSidebar");

  @Input()
  bool responsive = false;

  @Input()
  int widthPx = 250;

  bool open = false;

  String id = ui.uid('layout-');

  @override
  ngOnInit() {
  }

  void toggle() {
    open = !open;
  }


}
