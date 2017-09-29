import 'dart:html';

import 'package:angular2/core.dart';

@Component(
  selector: 'image-crop-showcase',
  template: r'''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>

  <div class="row--gutter">
    <p class="s4">
      <fnx-image-crop [ratio]="1.5" src="https://unsplash.it/300/100/?random" (crop)="crop1=$event"></fnx-image-crop>
      <br>{{crop1}}
    </p>
    <p class="s4">
      <fnx-image-crop [ratio]="1.5" src="https://unsplash.it/200/300/?random" (crop)="crop2=$event"></fnx-image-crop>
     <br>{{crop2}}
    </p>
    <p class="s4">
      <fnx-image-crop [ratio]="0.8" src="https://unsplash.it/1200/1400/?random" (crop)="crop3=$event"></fnx-image-crop>
      <br>{{crop3}}
    </p>
  </div>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga, nihil quae? Dolorum labore laudantium officiis quam reprehenderit? Dignissimos dolore eos facilis minus molestias nesciunt nihil quos ratione veritatis vitae, voluptates!</p>


  ''',
)
class ImageCropShowcase {
  Rectangle<double> crop1;
  Rectangle<double> crop2;
  Rectangle<double> crop3;
}
