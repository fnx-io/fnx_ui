import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui_showcase/app_config.dart';
import 'package:fnx_ui_showcase/example_app.dart';

@Component(
  selector: 'cookbook-crop',
  templateUrl: 'cookbook_crop.html',
  directives: [
    fnxUiDirectives,
    coreDirectives,
    formDirectives,
    appDirectives
  ],
)
class CookbookCrop {

  ExampleApp app;

  Rectangle<double>? crop1;
  Rectangle<double>? crop2;
  Rectangle<double>? crop3;

  CookbookCrop(this.app);

}
