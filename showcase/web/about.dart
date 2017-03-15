// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

import 'example_buttons_renderer.dart';

@Component(
    selector: 'example-about',
    templateUrl: 'about.html',
    directives: const [ExampleButtonsRenderer]
)
class About {

}
