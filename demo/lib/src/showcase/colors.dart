import 'dart:html';
import 'package:angular2/core.dart';

@Component(
  selector: 'colors-showcase',
  template: '''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>
  
  <style>
    .example-color {
      width: 13em;
      float: left;
      padding: 0.5em;
    }
  
    .example-color * {
      padding: 0.1em;
      font-size: 0.8rem;
      font-family: monospace;
    }
  
    .example-color *:nth-child(5) {
      padding: 0.8em 0.1em;
      margin: 0.2em 0;
    }
  </style>
  
  <h2>Colors</h2>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam cum eligendi quod suscipit veritatis? Debitis modi mollitia optio provident quibusdam! Consequuntur illum quas suscipit ullam unde? Ipsa quaerat reprehenderit veniam?</p>
  
  <article class="panel padding margin--vertical">
    <h3>Themes</h3>
  
    <div>
      <nav class="navbar margin--big--bottom padding--fab">
        <h1>No-theme</h1>
        <span class="spacer"></span>
        <ul class="menu--horizontal">
          <li><a href="#">link</a></li>
          <li><a href="#">submenu</a>
            <ul class="menu--vertical">
              <li><a href="#">link</a></li>
              <li><a href="#">link</a></li>
            </ul>
          </li>
        </ul>
        <a href="#" class="btn--fab">add</a>
      </nav>
    </div>
  
    <div class="margin--big--bottom theme--fnx accent--red">
      <nav class="navbar padding--fab">
        <h1>theme--fnx accent--red</h1>
        <span class="spacer"></span>
        <ul class="menu--horizontal">
          <li><a href="#">link</a></li>
          <li><a href="#">submenu</a>
            <ul class="menu--vertical">
              <li><a href="#">link</a></li>
              <li><a href="#">link</a></li>
            </ul>
          </li>
        </ul>
        <a href="#" class="btn--fab">add</a>
      </nav>
    </div>
  
    <div class="margin--big--bottom theme--purple--d2 accent--blue--l2">
      <nav class="navbar padding--fab">
        <h1>theme--purple--d2 accent--blue--l2</h1>
        <span class="spacer"></span>
        <ul class="menu--horizontal">
          <li><a href="#">link</a></li>
          <li><a href="#">submenu</a>
            <ul class="menu--vertical">
              <li><a href="#">link</a></li>
              <li><a href="#">link</a></li>
            </ul>
          </li>
        </ul>
        <a href="#" class="btn--fab">add</a>
      </nav>
    </div>
  </article>
  
  <div id="colors" class="row--gutter">
  </div>
  
  <article class="panel padding margin--vertical">
    <h3>Color combinations</h3>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est facere hic labore minima odio. Alias distinctio eligendi quae qui rem? At, eos fugiat necessitatibus qui quia saepe sapiente sunt. Vitae.</p>
    <div>
      <p class="bg--black text--yellow">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate, eligendi, placeat? Accusantium adipisci alias assumenda eius, fugiat labore neque omnis similique sunt voluptatibus. Deserunt fugiat iste laborum quam recusandae. Quis.</p>
      <p class="bg--orange text--white">Lorem ipsum dolor sit amet, consectetur adipisicing elit. At autem blanditiis consequuntur cum, deserunt dignissimos dolore esse eveniet exercitationem, facere fuga harum id laboriosam mollitia, placeat quam quas sint voluptates.</p>
      <p class="bg--pink text--pink--d2">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolorem eligendi impedit magni neque obcaecati optio quaerat quibusdam repellendus saepe sapiente. At cum eius maiores nostrum quod sapiente soluta sunt vero!</p>
    </div>
  </article>
  ''',
)
class ColorsShowcase implements OnInit{

  @override
  ngOnInit() {
    generateColors();
  }

  void generateColors() {
    Element colorsPlace;

    if ((colorsPlace = querySelector('#colors')) != null) {
      List<String> colors = [
        'fnx', 'black', 'white', 'red', 'pink', 'purple', 'deep-purple', 'indigo', 'blue', 'light-blue', 'cyan',
        'teal', 'green', 'light-green', 'lime', 'yellow', 'amber', 'orange', 'deep-orange', 'brown', 'grey', 'blue-grey'
      ];

      List<String> modifiers = ['--l4', '--l3', '--l2', '--l1', '', '--d1', '--d2', '--d3', '--d4'];

      List<String> types = ['bg', 'text'];


      colors.forEach((String color) {
        types.forEach((String type) {
          Element article = new Element.article()..classes.addAll(['panel', 'padding', 's6', 'm3', 'l2']);

          modifiers.forEach((String modifier) {
            article.append(new Element.div()..classes.add('$type--$color$modifier')..text = '.$type--$color$modifier');
          });

          colorsPlace.append(article);
        });


      });
    }
  }
}
