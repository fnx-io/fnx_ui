// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:logging/logging.dart';
import 'package:angular2/common.dart';

@Component(
  selector: 'example-app',
  templateUrl: 'example_app.html'
)
class ExampleApp implements OnInit {

  final Logger log = new Logger("FnxApp");

  Map user = {
    'name': 'Ferda',
    'surname': 'Mravenec',
    'address': {'street': 'Pod Pampeliskou'},
    'mood': 'sad',
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
  Control userName = new Control('', Validators.compose([Validators.required, Validators.minLength(3)]));
  Control mood = new Control('', moodValidator);

  List<Map> moods = [{'id': 'happy', 'name': 'Being 😀'}, {'id': 'sad', 'name': 'Being 😑'}, {'id': 'troll', 'name': 'Be not ⚠️'}];

  FnxApp(FormBuilder fb) {
    this.userForm = fb.group({"name": userName, 'mood': mood});
  }

  ngOnInit() {
    log.fine("App started");
  }

}
