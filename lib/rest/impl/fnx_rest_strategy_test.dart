import 'package:fnx_ui/rest/fnx_rest_strategy.dart';
import 'dart:async';
import 'package:fnx_ui/app/fnx_app.dart';

class RestGetDummy extends RestGet {

  Future getEntity(FnxApp app, String url) {
    return new Future.delayed(new Duration(seconds:1), ()=> {
      "propInt": 1234567,
      "propString": "qwertyuiop",
      "propList": [1234,5678,9999],
      "propMap": {
        "mapInt": 987654321,
        "mapString": "poiuytrewq"
      }
    });
  }

}
