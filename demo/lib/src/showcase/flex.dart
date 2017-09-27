import 'package:angular2/core.dart';

@Component(
  selector: 'flex-showcase',
  template: '''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>  
  
  <h2>Flex</h2>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dicta expedita facilis iste maiores odit perspiciatis praesentium quo ratione velit veritatis. Autem beatae error, id neque obcaecati quae similique voluptate voluptates.</p>
  
  <article class="panel padding margin--vertical">
    <h3>Flex row</h3>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Culpa deserunt dolor earum exercitationem fugiat hic impedit ipsa, itaque iusto labore, libero perspiciatis quae quo reprehenderit similique sit tempora unde voluptatibus!</p>
  
    <div class="flex--row margin--bottom">
        <div class="border padding">no grow</div>
        <div class="border padding flex--grow">flex--grow</div>
        <div class="border padding">no grow</div>
        <div class="border padding">no grow</div>
    </div>
  
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium at consectetur deleniti doloremque doloribus exercitationem expedita iusto necessitatibus neque odio quibusdam ratione, sed soluta veritatis vero voluptas voluptate. Cum, officiis!</p>
  
    <div class="flex--row margin--top">
        <div class="border padding">no grow</div>
        <div class="border padding flex--grow">flex--grow</div>
        <div class="border padding flex--grow--2">flex--grow--2</div>
        <div class="border padding flex--grow--3">flex--grow--3</div>
    </div>
  </article>
  
  <article class="panel padding margin--vertical">
    <h3>Flex column</h3>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Culpa deserunt dolor earum exercitationem fugiat hic impedit ipsa, itaque iusto labore, libero perspiciatis quae quo reprehenderit similique sit tempora unde voluptatibus!</p>
  
    <div class="row--gutter margin--top" style="height: 25em">
  
      <div class="s6 flex--column margin--bottom">
        <div class="border padding">no grow</div>
        <div class="border padding flex--grow">flex--grow</div>
        <div class="border padding">no grow</div>
        <div class="border padding">no grow</div>
      </div>
  
      <div class="s6 flex--column">
        <div class="border padding">no grow</div>
        <div class="border padding flex--grow">flex--grow</div>
        <div class="border padding flex--grow--2">flex--grow--2</div>
        <div class="border padding flex--grow--3">flex--grow--3</div>
      </div>
  
    </div>
  </article>
  ''',
)
class FlexShowcase {}
