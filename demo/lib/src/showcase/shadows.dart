import 'package:angular2/core.dart';

@Component(
  selector: 'shadows-showcase',
  styles: const ['''
  :host p.bg--fnx {
    padding: 1em;
    margin: 1.5em;
  }
  '''],
  template: '''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>

  <h2>Shadows</h2>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloribus excepturi neque veniam! Aspernatur atque cum dignissimos doloribus expedita, illum impedit iusto laborum magnam nam nemo, quibusdam quo soluta totam ut.</p>
  
  <article class="panel margin--vertical padding">
    <h3>Simple</h3>
  
    <p class="shadow bg--fnx">shadow</p>
    <p class="shadow--big bg--fnx">shadow--big</p>  
    <p class="shadow--huge bg--fnx">shadow--huge</p>
  </article>
  
  <article class="panel margin--vertical padding">
    <h3>Raising</h3>

    <p class="shadow--raising bg--fnx">shadow--raising</p>
    <p class="shadow--big--raising bg--fnx">shadow--big--raising</p>
    <p class="shadow--huge--raising bg--fnx">shadow--huge--raising</p>
  
  </article>
  ''',
)
class ShadowsShowcase {}
