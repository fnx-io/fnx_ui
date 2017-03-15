// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

@Component(
    selector: 'example-buttons-renderer',
    template: '''
  <p class="margin--bottom padding--bottom border--bottom">
    Source codes for this example:
    <a target="_blank" href="https://github.com/fnx-io/fnx_ui/blob/master/showcase/web/{{name}}.dart" class="btn">Dart <span class="hide-on-s hide-on-m">source</span></a>
    <a target="_blank" href="https://github.com/fnx-io/fnx_ui/blob/master/showcase/web/{{name}}.html" class="btn">Template <span class="hide-on-s hide-on-m">source</span></a>
  </p>
'''
)
class ExampleButtonsRenderer {

  @Input()
  String name;

}
