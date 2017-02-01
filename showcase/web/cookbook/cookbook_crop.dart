import 'dart:html';

import 'package:angular2/core.dart';
import 'package:fnx_ui/src/components/image/fnx_image_crop.dart';

import '../example_app.dart';
import '../example_buttons_renderer.dart';

@Component(
    selector: 'cookbook-crop',
    templateUrl: 'cookbook_crop.html',
    directives: const [ExampleButtonsRenderer, FnxImageCrop]
)
class CookbookCrop {

  ExampleApp app;

  Rectangle<double> crop1;
  Rectangle<double> crop2;
  Rectangle<double> crop3;

  CookbookCrop(this.app);

}
