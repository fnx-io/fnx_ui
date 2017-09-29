import 'package:angular2/core.dart';

@Component(
  selector: 'typography-showcase',
  template: '''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>

  <h1>Typography</h1>
  
  <article class="panel margin--vertical padding">
    <h1>Importance of typography in the post-industrial era</h1>
  
    <h2>Lorem ipsum</h2>
  
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ad adipisci corporis cumque cupiditate dicta eaque earum est eveniet ex itaque magni natus perferendis, quae quaerat quas sequi similique vitae voluptatum?</p>
  
    <h3>Dolor sit amet</h3>
  
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab cupiditate fuga illo nesciunt odio ullam. Cum cupiditate enim, expedita fugiat inventore magnam maiores minima possimus, quam quas, quis unde velit.</p>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Excepturi iure quibusdam tempora vel. Accusamus aliquid dolorum earum, ex maiores maxime neque non nostrum odit officia, quasi repellat rerum sunt! Voluptatibus.</p>
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. At atque eum magni necessitatibus ratione veniam vitae, voluptatum! Delectus, iure natus nemo nostrum provident repellendus. Ad eveniet laudantium officia provident qui.</p>

    <h1>Heading 1</h1>
    <h2>Heading 2</h2>
    <h3>Heading 3</h3>
    <h4>Heading 4</h4>
    <h5>Heading 5</h5>
    <h6>Heading 6</h6>
  
    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda, culpa distinctio eum explicabo fugiat, fugit impedit iste libero minima nulla pariatur sint suscipit vel. Amet eum illum ipsam perspiciatis sequi.</p>
  
    <p>Lorem ipsum dolor sit amet, <a href="#">consectetur adipisicing elit</a>. Aut blanditiis et eveniet incidunt iusto laudantium quae quam, quasi. <a>Adipisci aperiam aut dicta</a> dolorum enim ipsam iure necessitatibus rerum, totam voluptatibus!</p>
  </article>
  
  <article class="panel margin--vertical padding">
    <p class="fs-xs">fs-xs - Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
    <p class="fs-s">fs-s - Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
    <p class="fs-m">fs-m - Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
    <p class="fs-l">fs-l - Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
    <p class="fs-xl">fs-xl - Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
    <p class="fs-xxl">fs-xxl - Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
    <p class="fs-xxxl">fs-xxxl - Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
  </article>
  
  <article class="panel margin--vertical padding">
    <p class="border padding bold">bold - Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
    <p class="border padding underline">underline - Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
    <p class="border padding italics">italics - Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
    <p class="border padding strike">strike, line-through - Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
    <p class="border padding monospace">monospace - Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
  
    <p class="border padding text--center">lorem ipsum</p>
    <p class="border padding text--right">lorem ipsum</p>
    <p class="border padding text--left">lorem ipsum</p>
  </article>
  
  <article class="panel margin--vertical padding">
    <ul>
      <li>Lorem ipsum dolor sit amet</li>
      <li>consectetur adipisicing elit</li>
      <li>Ad aliquam, aspernatur culpa eveniet impedit</li>
      <li>laudantium magnam non odit officiis</li>
      <li>quaerat quas quibusdam quidem</li>
      <li>quisquam quo repellat saepe sed totam vero</li>
    </ul>
  </article>

  ''',
)
class TypographyShowcase {}
