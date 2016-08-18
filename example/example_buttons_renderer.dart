// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:angular2/router.dart';
import 'package:fnx_ui/src/components/modal/fnx_modal.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import 'example_testing.dart';
import 'example_panels.dart';

@Component(
    selector: 'example-buttons-renderer',
    template: '''
  <p class="margin--bottom padding--bottom border--bottom">
    Source codes for this example:
    <a target="_blank" href="https://github.com/fnx-io/fnx_ui/blob/master/example/{{name}}.dart" class="btn">Dart source</a>
    <a target="_blank" href="https://github.com/fnx-io/fnx_ui/blob/master/example/{{name}}.html" class="btn">Template source</a>
  </p>
'''
)
class ExampleButtonsRenderer {

  @Input()
  String name;

}
