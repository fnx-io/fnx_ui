import 'dart:math';

import 'package:angular2/core.dart';

@Component(
  selector: 'lazy-loading-showcase',
  template: r'''
  <!--
  Hi there fellow developer!
  
  Please note, most of the css classes here are pretty vital for this example. Be sure to use:
  
  - fit and flex--column in wrapper
  - flex--grow and flex--shrink in fnx-scroll-panel
  -->
  <div class="flex--column fit padding">
    <div>
      <button type="submit" 
              class="btn margin--bottom" 
              data-prefix="arrow_back"
              [routerLink]="['Default']"> 
        back to documentation
      </button>
    </div>
  
    <div class="row--gutter">
      <fnx-input class="s12 m6 l3">
        <fnx-check label="table--borders" [(ngModel)]="bordersOn"></fnx-check>
      </fnx-input>
      <fnx-input class="s12 m6 l3">
        <fnx-check label="table--lines" [(ngModel)]="linesOn"></fnx-check>
      </fnx-input>
      <fnx-input class="s12 m6 l3">
        <fnx-check label="table--stripes" [(ngModel)]="stripesOn"></fnx-check>
      </fnx-input>
      <fnx-input class="s12 m6 l3">
        <fnx-check label="table--active" [(ngModel)]="activeOn"></fnx-check>
      </fnx-input>
    </div>
  
    <p class="text--red">Please note the fixed footer at the bottom ...</p>
  
    <fnx-form (submit)="search = fulltext.value">
      <div class="flex--row margin--vertical">
        <fnx-text autoFocus #fulltext class="flex--grow flex--shrink margin--right"></fnx-text>
        <button class="btn margin--small--right" (click)="search = fulltext.value">Search</button>
        <button type="reset" class="btn icon" [class.disabled]="search == null" (click)="search = null">cancel</button>
      </div>
    </fnx-form>
  
    <h5 *ngIf="search != null">Searching for '{{search}}':</h5>
  
    <fnx-scroll-panel class="flex--grow flex--shrink margin--bottom" (loadMore)="loadMore()">
      <table [class.table--borders]="bordersOn" [class.table--lines]="linesOn" [class.table--stripes]="stripesOn" [class.table--active]="activeOn">
        <tr>
          <th>
            <span class="spacer">ID</span>
            <span class="dropdown">
              <ul class="menu--vertical">
                <li><span>item</span></li>
                <li><span>item</span></li>
                <li><span>item</span></li>
                <li><span>item</span></li>
              </ul>
            </span>
          </th>
          <th>
            <span class="spacer">jmeno</span>
            <span class="dropdown">
              <ul class="menu--vertical">
                <li><span>item</span></li>
                <li><span>item</span></li>
                <li><span>item</span></li>
                <li><span>item</span></li>
              </ul>
            </span>
  
          </th>
          <th>
            <span class="spacer">email</span>
            <span class="dropdown">
              <ul class="menu--vertical">
                <li><span>item</span></li>
                <li><span>item</span></li>
                <li><span>item</span></li>
                <li><span>item</span></li>
              </ul>
            </span>
          </th>
        </tr>
        <tr *ngFor="let row of list" (click)="selectedRow = row">
          <td>{{row["id"]}}</td>
          <td>{{row["name"]}}</td>
          <td>{{row["email"]}}</td>
          </tr>
        </table>
    </fnx-scroll-panel>
  
    <fnx-modal (close)="selectedRow = null" *ngIf="selectedRow != null">
        <h3 header>{{selectedRow["name"]}}</h3>
        <div main>
            {{selectedRow}}
        </div>
        <div footer class="text--right padding">
            <button (click)="selectedRow = null" class="btn">close</button>
        </div>
    </fnx-modal>
  
    <p class="text--red">Fixed footer here, thank you ... lorem ipsum.</p>
  </div>
  ''',
)
class LazyLoadingShowcase {
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

  String search;

  bool bordersOn = false;
  bool linesOn = false;
  bool stripesOn = false;
  bool activeOn = true;
  Map selectedRow;

  ngOnInit() {
    loadMore();
  }

  Iterable get list {
    if (search == null) return listData;
    return listData.where(containsSearch);
  }

  bool containsSearch(Map<String, Object> row) {
    return row["name"].toString().contains(search) || row["email"].toString().contains(search);
  }
}
