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
    selector: 'cookbook-select-or-create',
    templateUrl: 'cookbook_select_or_create.html',
    directives: const [ExampleButtonsRenderer]
)
class CookbookSelectOrCreate {

  int id = 6;
  
  FnxApp app;

  List persons = [
      {"id":1, "name":"John Smith", "occupation":"warrior", "phone":"4235532423"},
      {"id":2, "name":"Kevin Baker", "occupation":"mage", "phone":"936246323"},
      {"id":3, "name":"Emma Govinda", "occupation":"paladin", "phone":"423434334"},
      {"id":4, "name":"Alice Cooper", "occupation":"thief", "phone":"967423514"},
      {"id":5, "name":"George Holmes", "occupation":"detective", "phone":"4265321456"},
    ];

  Map<int, Map> personsById = {};

  List<int> members = []; // first element - empty, waiting for selection

  Map createPerson = {};
  
  CookbookSelectOrCreate(this.app) {
    persons.forEach((Map member) {
      personsById[member['id']] = member;
    });
  }

  bool openCreateModal = false;

  void removeMember(int index) {
    members.removeAt(index);
  }

  String renderPersonSelectDescription() {
    if (members.isEmpty) {
      return "Select a person ...";
    } else {
      return "Select a person (${members.length} selected)";
    }
  }

  void createNewPerson() {

    // send to server, validate, receive id
    createPerson["id"] = id++;

    // add to local copies
    persons.add(createPerson);
    personsById[createPerson["id"]] = createPerson;

    // insert as the last value
    members.add(createPerson["id"]);

    // rest form
    createPerson = {};

    // hide form
    openCreateModal = false;
  }
  
}
