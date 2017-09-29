import 'dart:math';

import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'master-detail-showcase',
  template: r'''  
  <div class="flex--column fit padding">  
    <div>
      <button type="submit" 
              class="btn margin--bottom" 
              data-prefix="arrow_back"
              [routerLink]="['Default']"> 
        back to documentation
      </button>
    </div>
  
    <fnx-scroll-panel class="flex--grow flex--shrink margin--bottom table--stripes table--lines" (loadMore)="loadMore()">
      <table class="table--active">
        <tr *ngFor="let row of list"
            style="cursor: pointer"
            [class.selected]="row == selected"
            (click)="selected = row">
          <td>{{row["id"]}}</td>
          <td>{{row["name"]}}</td>
          <td>{{row["email"]}}</td>
        </tr>
      </table>
    </fnx-scroll-panel>
  
    <div class="padding--vertical border--top" *ngIf="selected != null">
      <h3>{{selected['name']}}</h3>
      <p><a href="{{selected['email']}}">{{selected['email']}}</a></p>
      <p class="text--right">
        <a (click)="todo()" class="btn">delete</a>
        <a (click)="todo()" class="btn">edit</a>
        <a (click)="todo()" class="btn">confirm</a>
      </p>
    </div>
  
  </div>
  ''',
)
class MasterDetailShowcase {
  Random r = new Random();

  List<Map<String, Object>> listData = [];

  List<String> names = [
    "Alice",
    "Chains",
    "Pink",
    "Floyd",
    "Jethro",
    "Tull",
    "Led",
    "Zeppelin",
    "Iron",
    "Maiden",
    "Velvet",
    "Underground",
    "Tenacious",
    "D",
    "Jefferson",
    "Airplane",
    "Rolling",
    "Stones",
    "Grateful",
    "Dead"
  ];

  void loadMore() {
    if (listData.length >= 500) return;

    for (int a = 0; a < 10; a++) {
      Map<String, Object> row = {};
      String n1 = names[r.nextInt(names.length)];
      String n2 = names[r.nextInt(names.length)];
      String n3 = names[r.nextInt(names.length)];

      row["id"] = listData.length + 1;
      row["name"] = "$n1 $n2";
      row["email"] = "$n1.$n2@$n3.com".toLowerCase();

      listData.add(row);
    }
  }

  FnxApp app;

  var selected = null;

  MasterDetailShowcase(this.app);

  ngOnInit() {
    loadMore();
  }

  List get list => listData;

  void todo() {
    app.alert("This function is not implemented. Why would be, this is a master-detail example", headline: "This is not a real app");
  }
}
