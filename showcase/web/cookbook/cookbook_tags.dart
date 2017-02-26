// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import '../example_app.dart';
import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/components/modal/fnx_modal.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import '../example_buttons_renderer.dart';

@Component(
    selector: 'cookbook-tags',
    templateUrl: 'cookbook_tags.html',
    directives: const [ExampleButtonsRenderer]
)
class CookbookTags {

  ExampleApp app;

  CookbookTags(this.app);

  List<String> allTags = ["TODO", "postpone", "info", "alert", "VIP", "promo", "featured", "FIXME", "approved", "draft",
                          "public", "secret", "important", "obsolete", "delete me", "news", "HOT"]..sort();

  List<String> usedTags = [];

  String renderTagSelectDescription() {
    if (usedTags.isEmpty) {
      return "Select tags ...";
    } else {
      return "Select tags (${usedTags.length} selected)";
    }
  }

}
