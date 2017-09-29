import 'package:angular2/core.dart';

@Component(
  selector: 'dynamic-rows-showcase',
  template: r'''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>

  <!-- Rows -->
  <div *ngFor="let r of rows" class="flex--row margin--bottom">

    <fnx-text class="flex--grow flex--shrink"
              [(ngModel)]="r['name']"></fnx-text>

    <button class="btn icon margin--small--left bg--primary" (click)="removeRow(r)">remove</button>
  </div>

  <!-- Add more button -->
  <div class="text--right">
    <button class="btn icon bg--accent" (click)="addRow()">add</button>
  </div>

  <p class="padding f-monospace">
    Debug: {{rows}}
  </p>
  ''',
)
class DynamicRowsShowcase {
  List rows = [
    {"name": "One"},
    {"name": "Two"},
  ];

  void addRow() {
    rows.add({});
  }

  void removeRow(var element) {
    rows.remove(element);
  }
}
