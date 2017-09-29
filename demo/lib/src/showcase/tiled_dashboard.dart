import 'dart:math';

import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'tiled-dashboard-showcase',
  styles: const [r'''
  :host .badge {
    width: 2em;
    height: 2em;
    line-height: 2em;
    text-align: center;
    position: absolute;
    top: -0.5em;
    right: -0.5em;
    border-radius: 50%;
  }
  '''],
  template: r'''
  <button type="submit" 
          class="btn margin--bottom" 
          data-prefix="arrow_back"
          [routerLink]="['Default']"> 
    back to documentation
  </button>

  <div class="row--gutter text--center">
    <a *ngFor="let tile of tiles" class="s6 m4 l2 card padding shadow--raising {{tile.color}}" (click)="doExampleFeedback(tile)">
      <p>{{tile.text}}</p>
      <p class="mi fs-xxxl">{{tile.icon}}</p>
      <span class="badge bg--red" *ngIf="tile.count > 0">{{tile.count}}</span>
    </a>
  </div>
  ''',
)
class TiledDashboardShowcase {
  FnxApp app;

  List<TileModel> tiles = [];

  TiledDashboardShowcase(this.app) {
    tiles.add(new TileModel("Some action", "accessible", "bg--fnx"));
    tiles.add(new TileModel("Other action", "warning", "bg--white"));
    tiles.add(new TileModel("No action", "android", "bg--white"));
    tiles.add(new TileModel("Bad action", "build", "bg--fnx"));
    tiles.add(new TileModel("Good action", "backup", "bg--fnx"));
    tiles.add(new TileModel("The best action", "extension", "bg--fnx"));
    tiles.add(new TileModel("Unknown action", "face", "bg--fnx"));
    tiles.add(new TileModel("Active action", "grade", "bg--white"));
    tiles.add(new TileModel("Pasive action", "language", "bg--white"));
    tiles.add(new TileModel("The worst action", "lock", "bg--yellow"));
    tiles.add(new TileModel("Frequent action", "loop", "bg--white"));
    tiles.add(new TileModel("Rare action", "web", "bg--white"));
    tiles.add(new TileModel("Hidden action", "call", "bg--white"));
    tiles.add(new TileModel("Stupid action", "save", "bg--yellow"));
    tiles.add(new TileModel("Smart action", "cloud", "bg--white"));
    tiles.add(new TileModel("Example action", "watch", "bg--yellow"));
    tiles.add(new TileModel("Quick action", "lens", "bg--white"));
    tiles.add(new TileModel("Slow action", "navigation", "bg--yellow"));

    tiles.shuffle();
  }

  void doExampleFeedback(TileModel t) {
    app.toast("You clicked on '${t.text}'! Great!");
  }
}

class TileModel {
  static Random rnd = new Random();

  String text;
  String icon;
  String color;
  int count = 0;

  TileModel(this.text, this.icon, this.color) {
    if (rnd.nextDouble() > 0.7) {
      count = rnd.nextInt(20);
    }
  }
}
