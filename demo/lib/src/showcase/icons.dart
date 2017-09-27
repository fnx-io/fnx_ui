import 'package:angular2/core.dart';

@Component(
  selector: 'icons-showcase',
  template: '''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>
  
  <h2>Icons</h2>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ad aliquid autem blanditiis cum delectus doloribus eligendi necessitatibus quaerat sapiente sunt? Asperiores atque eum libero mollitia praesentium quia tempora ut voluptate.</p>
  
  <article class="panel padding margin--vertical">
    <h3>Icons in text</h3>
    <p>
        Lorem <i class="mi">screen_lock_rotation</i>
        ipsum <i class="mi">airplanemode_active</i>
        sit <i class="mi">bug_report</i>
        amet.</p>
    <p class="fs-xl">
        Lorem <i class="mi">screen_lock_rotation</i>
        dolor <i class="mi">add_circle_outline</i>
        sit <i class="mi">bug_report</i>
        amet.</p>
  </article>
  
  <article class="panel padding margin--vertical">
    <h3>Plain icons</h3>
    <p>
      <a href="#" class="icon bg--fnx--d1">cancel</a>
      <span class="icon bg--fnx--d2">delete</span>
  
      <a href="#" class="icon icon--round bg--fnx--d3">cancel</a>
      <span class="icon icon--round bg--fnx--d4">delete</span>
    </p>
  </article>
  
  <article class="panel padding margin--vertical">
    <h3>Icons with shadow</h3>
    <p>
      <span class="icon bg--fnx--d1 shadow">cancel</span>
      <span class="icon bg--fnx--d2 shadow">delete</span>
  
      <span class="icon icon--round bg--fnx--d3 shadow">cancel</span>
      <span class="icon icon--round bg--fnx--d4 shadow">delete</span>
    </p>
  </article>
  
  <article class="panel padding margin--vertical">
    <h3>Buttonish icons</h3>
    <p>
      <span class="btn icon bg--fnx--d1 ">cancel</span>
      <span class="btn icon bg--fnx--d2">delete</span>
  
      <span class="btn icon bg--fnx--d3">cancel</span>
      <span class="btn icon bg--fnx--d4">delete</span>
    </p>
  </article>
  
  <article class="panel padding margin--vertical">
    <h3>Icons in navbar</h3>
    <nav class="navbar bg--fnx">
      <span class="mi fs-xxxl">screen_lock_rotation</span>
      <h1>Navbar</h1>
  
      <span class="spacer"></span>
  
      <a class="mi">delete</a>
      <span class="mi">add_circle_outline</span>
      <a class="icon text--fnx--l4">cancel</a>
      <span class="icon text--fnx--l3">delete</span>
      <span class="icon icon--round text--fnx--l2">cancel</span>
      <span class="icon icon--round text--fnx--l1">delete</span>
  
    </nav>
  </article>
  ''',
)
class IconsShowcase {}
