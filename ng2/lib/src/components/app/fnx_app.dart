// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';

@Component(
  selector: 'fnx-app',
  templateUrl: 'fnx_app.html'
)
class FnxApp implements OnInit {

  final Logger log = new Logger("FnxApp");

  FnxApp() {
  }

  ngOnInit() {
    log.fine("App started");
  }

}
