// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/app/fnx_app.dart';
import 'package:fnx_ui/src/util/pair.dart';
import 'package:fnx_ui_showcase/app_config.dart';
import 'package:logging/logging.dart';

@Component(
    selector: 'example-testing',
    templateUrl: 'example_testing.html',
    directives: [
      fnxUiDirectives,
      coreDirectives,
      formDirectives,
      appDirectives
    ],
)
class ExampleTesting implements OnInit {

  FnxApp app;

  final Logger log = new Logger("FnxApp");

  PickImageUrl dumbImagePicker;

  List reorderItems = ["jedna", "dva", "tri", "ctyri", "pet"];

  Map user = {
    'name': 'Ferda',
    'surname': 'Mravenec',
    'address': {'street': 'Pod Pampeliskou'},
    'mood': 'sad',
    'double': 21.2,
    'dead': false,
    'wysiwyg_poor': "<p>Nalevna v plenéru. Najdete tam <strong>všechno</strong>:</p><ul><li>pivo</li><li>víno</li><li>limo</li><li>ovo</li></ul><h1>Must see!"
        "<a href='http://www.seznam.cz/'>Seznam</a> <a href='ftp://www.neznam.cz/'>Neznam</a>"
        "</h1>",
    'birthday': '2016-06-22T15:22:30.638489'};

  int shoeSize;
  double velocity;

  bool readonly = false;

  static dynamic moodValidator = (AbstractControl c) {
    if (c.value == null) return null;
    List selected;
    if (c.value is List) {
      selected = c.value as List;
    } else {
      selected = [c.value];
    }
    if (selected.contains('happy')) {
      return null;
    }
    return {'mood': {'happy': false}};
  };

  List<Map> moods = [{'id': 'happy', 'name': 'Being 😀'}, {'id': 'sad', 'name': 'Being 😑'}, {'id': 'troll', 'name': 'Be not ⚠️'}];

  List<String> allOptions;

  ExampleTesting(this.app) {
    this.dumbImagePicker = () => (app.input("Image url please") as Future<String>);

    Random r = new Random();
    allOptions = new List.generate(1000, (_)=>r.nextInt(10e8.toInt()).toString());
  }

  void doReorder(ReorderEvent ev) {
    ev.applyToList(reorderItems);
  }

  ngOnInit() {
    user['group'] = allOptions.first;
  }

  Future<Pair> defaultOptionProvider(var initialValue) =>
      new Future.delayed(new Duration(milliseconds: 45)).then((_) =>
      new Pair(initialValue, "$initialValue")
      );

  Future<List<Pair>> optionsProvider(String filledText) {
    return new Future.delayed(new Duration(milliseconds: 90)).then((_) {
      return allOptions
          .where((String opt) => opt.contains(filledText))
          .take(30)
          .map((String s) => new Pair(s, "$s"))
          .toList();
    });
  }

}
