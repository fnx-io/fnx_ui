import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'step-picker-showcase',
  template: r'''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>

  <h1 class="margin--big--bottom">Please pick the right value</h1>
  
  <div class="row--gutter">
  
    <div class="s12 m4 flex--column">
      <fnx-scroll-panel class="flex--grow flex--shrink">
        <div class="menu--vertical">
          <a  *ngFor="let item of step1"
              class="item"
              [class.selected]="selected1 == item"
              [attr.data-suffix]="selected1 == item ? 'chevron_right' : ''"
              (click)="loadStep2(item)">{{item}}</a>
        </div>
      </fnx-scroll-panel>
    </div>
  
    <div class="s12 m4 flex--column">
      <fnx-scroll-panel class="flex--grow flex--shrink">
        <div class="menu--vertical">
          <a  *ngFor="let item of step2"
              class="item"
              [class.selected]="selected2 == item"
              [attr.data-suffix]="selected2 == item ? 'chevron_right' : ''"
              (click)="loadStep3(item)">{{item}}</a>
        </div>
      </fnx-scroll-panel>
    </div>
  
    <div class="s12 m4 flex--column">
      <fnx-scroll-panel class="flex--grow flex--shrink">
        <div class="menu--vertical">
          <a class="item" *ngFor="let item of step3" (click)="finish(item)">{{item}}</a>
        </div>
      </fnx-scroll-panel>
    </div>
  </div>
  ''',
)
class StepPickerShowcase {
  FnxApp app;

  StepPickerShowcase(this.app);

  String selected1 = null;
  String selected2 = null;

  List<String> step1 = ['A', 'B', 'C', 'D', 'E'];
  List<String> step2 = [];
  List<String> step3 = [];

  void loadStep2(String item) {
    selected1 = item;
    step2 = [];

    for (int a = 1; a < 8; a++) {
      step2.add("$item.$a");
    }
  }

  void loadStep3(String item) {
    selected2 = item;
    step3 = [];
    for (int a = 1; a < 12; a++) {
      step3.add("$item - $a");
    }
  }

  void finish(String item) {
    app.confirm("Please confirm that '$item' is the right value").then((bool result) {
      if (result) app.toast("Great!");
    });
  }
}
