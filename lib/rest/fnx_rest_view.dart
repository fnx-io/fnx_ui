@HtmlImport("fnx_rest_view.html")
library fnx_ui.fnx_rest_view;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/paper_ripple.dart';
import 'package:polymer_elements/paper_material.dart';

import '../fnx_ui.dart';
import 'package:fnx_router/fnx_router_behavior.dart';
import 'package:fnx_ui/rest/impl/fnx_rest_strategy_test.dart';
import 'dart:async';
import 'package:fnx_ui/rest/fnx_rest_strategy.dart';
import 'package:fnx_ui/app/fnx_app.dart';
import 'package:logging/logging.dart';

@PolymerRegister("fnx-rest-view")
class FnxRestView extends PolymerElement with FnxRouterBehavior, FnxAppAwareBehavior {

  Logger _log = new Logger("FnxRestView");

  @property
  String url;

  @Property(notify: true, reflectToAttribute: true)
  Map entity;

  FnxRestView.created() : super.created();

  @override
  void routeChanged(bool visible, List<String> params, bool visibilityChanged) {
    if (visibilityChanged) {
      _log.info("Clearing view null");
      set("entity", {});
    }
    if (visible) {
      RestGetDummy restGet = new RestGetDummy();
      restGetImpl(url, restGet);
    }
  }

  void restGetImpl(String url, RestGet restGet) {
    _log.info("Loading from ${url} using ${restGet}");
    fnxApp.workStarted();
    Future<Map> data = restGet.getEntity(fnxApp, url);

    data
      .then((Map data) {
        _log.info("Data loaded: ${data}");
        set("entity", data);
      })
      .catchError((error) {
        _log.severe("Error loading data: ${error}");
      })
      .then((_) {
        fnxApp.workFinished();
      });
  }

  get(String path, [root]) {
    print("Get $path $root");
    super.get(path, root);
  }


  void set(String path, value) {
    print("Set $path $value");
    super.set(path, value);
  }


}
