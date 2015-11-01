library fnx_ui.fnx_rest_strategy;

import 'package:fnx_ui/app/fnx_app.dart';
import 'dart:async';

abstract class RestGet {

  Future<Map> getEntity(FnxApp app, String url);

}

abstract class RestSave {

  Future saveEntity(FnxApp app, String url, var entity);

}

abstract class RestCreate {

  Future createEntity(FnxApp app, String url, var entity);

}

abstract class RestDelete {

  Future deleteEntity(FnxApp app, String url, var entity);

}