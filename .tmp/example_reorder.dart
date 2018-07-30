// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:logging/logging.dart';

import 'app_config.dart';

@Component(
  selector: 'example-reorder',
  templateUrl: 'example_reorder.html',
  directives: [
    fnxUiDirectives,
    coreDirectives,
    formDirectives,
    appDirectives
  ],
)
class ExampleReorder {

  final Logger log = new Logger("ExampleReorder");

  ExampleReorder();

  List<String> items = [
    "Tyrion Lannister",
    "Jaime Lannister",
    "Cersei Lannister",
    "Joffrey Baratheon",
    "Tywin Lannister"
  ];

  String get firstItem => items[0];

  Iterable<String> get restOfTheItems => items.skip(1);

  void onReorder(ReorderEvent e) {
    e.applyToList(items);
  }

}
