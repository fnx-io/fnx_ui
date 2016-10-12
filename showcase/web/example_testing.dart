// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/components/modal/fnx_modal.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import 'example_buttons_renderer.dart';

@Component(
    selector: 'example-testing',
    templateUrl: 'example_testing.html',
    directives: const [ExampleButtonsRenderer]
)
class ExampleTesting implements OnInit {

  FnxApp app;

  final Logger log = new Logger("FnxApp");

  Map user = {
    'name': 'Ferda',
    'surname': 'Mravenec',
    'address': {'street': 'Pod Pampeliskou'},
    'mood': 'sad',
    'dead': false,
    'birthday': '2016-06-22T15:22:30.638489'};

  static dynamic moodValidator = (AbstractControl c) {
    if (c.value == null) return null;
    List selected;
    if (c.value is List) {
      selected = c.value;
    } else {
      selected = [c.value];
    }
    if (selected.contains('happy')) {
      return null;
    }
    return {'mood': {'happy': false}};
  };

  ControlGroup userForm;
  Control userName = new Control('', Validators.maxLength(5));
  Control mood = new Control('', moodValidator);

  List<Map> moods = [{'id': 'happy', 'name': 'Being 😀'}, {'id': 'sad', 'name': 'Being 😑'}, {'id': 'troll', 'name': 'Be not ⚠️'}];

  ExampleTesting(this.app, FormBuilder fb) {
    this.userForm = fb.group({"name": userName, 'mood': mood});
  }

  ngOnInit() {
    log.fine("App started");
  }

}
