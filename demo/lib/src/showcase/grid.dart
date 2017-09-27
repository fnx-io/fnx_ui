import 'package:angular2/core.dart';

@Component(
  selector: 'grid-showcase',
  template: '''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>  
    
  <style>
    .row > * {
      border: 1px solid black;
    }
    .row--gutter > * {
      border: 1px solid black;
    }
    .row--gutter--horizontal > * {
      border: 1px solid black;
    }
  </style>
  
  <h2>Grid</h2>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dicta expedita facilis iste maiores odit perspiciatis praesentium quo ratione velit veritatis. Autem beatae error, id neque obcaecati quae similique voluptate voluptates.</p>
  
  <article class="panel padding margin--vertical">
    <h3>Tight grid</h3>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Culpa deserunt dolor earum exercitationem fugiat hic impedit ipsa, itaque iusto labore, libero perspiciatis quae quo reprehenderit similique sit tempora unde voluptatibus!</p>
  
    <div class="row margin--top">
      <div class="s12 m6 l3">s12 m6 l3</div>
      <div class="s12 m6 l3">s12 m6 l3</div>
      <div class="s12 m6 l3">s12 m6 l3</div>
      <div class="s12 m6 l3">s12 m6 l3</div>
      <div class="s12">s12</div>
    </div>
  </article>
  
  <article class="panel padding margin--vertical">
    <h3>Grid with gutter</h3>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Culpa deserunt dolor earum exercitationem fugiat hic impedit ipsa, itaque iusto labore, libero perspiciatis quae quo reprehenderit similique sit tempora unde voluptatibus!</p>
  
    <div class="row--gutter margin--top">
      <div class="s12 m6 l3">s12 m6 l3</div>
      <div class="s12 m6 l3">s12 m6 l3</div>
      <div class="s12 m6 l3">s12 m6 l3</div>
      <div class="s12 m6 l3">s12 m6 l3</div>
      <div class="s12">s12</div>
    </div>
  </article>
  
  <article class="panel padding margin--vertical">
    <h3>Grid with horizontal gutter</h3>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Culpa deserunt dolor earum exercitationem fugiat hic impedit ipsa, itaque iusto labore, libero perspiciatis quae quo reprehenderit similique sit tempora unde voluptatibus!</p>
  
    <div class="row--gutter--horizontal margin--top">
      <div class="s12 m6 l3">s12 m6 l3</div>
      <div class="s12 m6 l3">s12 m6 l3</div>
      <div class="s12 m6 l3">s12 m6 l3</div>
      <div class="s12 m6 l3">s12 m6 l3</div>
      <div class="s12">s12</div>
    </div>
  </article>
  
  <article class="panel padding margin--vertical">
    <h3>Offset</h3>
    <p></p>
  
    <div class="row--gutter margin--top">
      <div class="s12 m8 offset--m2 l6 offset--l3">Look, I'm centered: s12 m8 offset--m2 l6 offset--l3</div>
      <div class="s4 offset--s8">s4 offset--s8</div>
      <div class="s4">s4</div>
    </div>
  </article>
  ''',
)
class GridShowcase {}
