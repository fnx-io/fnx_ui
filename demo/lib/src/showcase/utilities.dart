import 'dart:html';
import 'package:angular2/core.dart';

@Component(
  selector: 'utilities-showcase',
  styles: const [r'''
  :host .demo--col {
    width: 12%;
    display: inline-block;
    border: 1px dotted #cdcdcd;
    background-color: #ddd;
    margin: 1%;
    vertical-align: top;
    background: #fff;
  }
  '''],
  template: r'''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>
  
  <h1>Utilities</h1>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Corporis doloremque eius eveniet explicabo magnam, reiciendis sunt voluptates? A at beatae delectus magnam neque perferendis sequi? Eum facere itaque nobis numquam?</p>
  
  <section id="utils"></section>
  
  <article>
    <p class="border margin--auto" style="width: 30em">.margin--auto</p>
    <p class="border margin--auto width--third">.margin--auto .width--third</p>
    <p class="border margin--auto width--half">.margin--auto .width--half</p>
  </article>
  
  <article>
    <p class="border margin--auto width--10">.margin--auto .width--10</p>
    <p class="border margin--auto width--20">.margin--auto .width--20</p>
    <p class="border margin--auto width--30">.margin--auto .width--30</p>
    <p class="border margin--auto width--40">.margin--auto .width--40</p>
    <p class="border margin--auto width--50">.margin--auto .width--50</p>
    <p class="border margin--auto width--60">.margin--auto .width--60</p>
    <p class="border margin--auto width--70">.margin--auto .width--70</p>
    <p class="border margin--auto width--80">.margin--auto .width--80</p>
    <p class="border margin--auto width--90">.margin--auto .width--90</p>
    <p class="border margin--auto width--100">.margin--auto .width--100</p>
  </article>
''',
)
class UtilitiesShowcase implements OnInit{

  @override
  ngOnInit() {
    generateUtils();
  }

  void generateUtils() {
    Element utilsPlace;

    if ((utilsPlace = querySelector('#utils')) != null) {
      List<String> properties = ['padding', 'padding--small','padding--big','margin','margin--small','margin--big', 'border'];
      List<String> modes = ['', '--top', '--bottom', '--left', '--right', '--vertical', '--horizontal'];

      properties.forEach((String property) {
        Element article = new Element.article()..classes.addAll(['panel', 'padding', 'margin--vertical']);

        modes.forEach((String mode) {
          Element el = new Element.div()..classes.addAll(['demo--col']);

          el.append(new Element.div()
            ..classes.addAll(['$property$mode'])
            ..innerHtml = '.$property$mode<br>.$property$mode<br>.$property$mode<br>.$property$mode'
          );

          article.append(el);
        });

        utilsPlace.append(article);
      });
    }
  }
}
