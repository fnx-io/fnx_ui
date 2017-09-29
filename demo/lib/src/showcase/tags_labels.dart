import 'package:angular2/core.dart';

@Component(
  selector: 'tags-labels-showcase',
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
  
  <fnx-form>
    <fnx-input label="Tags and labels">
      <div>
        <p class="no-margin" *ngIf="usedTags.isNotEmpty">
            <span class="tag margin--small--bottom margin--small--right" *ngFor="let tag of usedTags">{{tag}} <a (click)="usedTags.remove(tag)" class="mi">clear</a></span>
        </p>
        <fnx-select [(ngModel)]="usedTags"
                    [allwaysShowFilter]="true"
                    [multi]="true"
                    [valueDescriptionRenderer]="renderTagSelectDescription">
          <fnx-option [label]="item" [value]="item" *ngFor="let item of allTags"></fnx-option>
        </fnx-select>
      </div>
    </fnx-input>
  </fnx-form>
</div>
  ''',
)
class TagsLabelsShowcase {
  List<String> allTags = [
    "TODO",
    "postpone",
    "info",
    "alert",
    "VIP",
    "promo",
    "featured",
    "FIXME",
    "approved",
    "draft",
    "public",
    "secret",
    "important",
    "obsolete",
    "delete me",
    "news",
    "HOT"
  ]..sort();

  List<String> usedTags = [];

  String renderTagSelectDescription() {
    if (usedTags.isEmpty) {
      return "Select tags ...";
    } else {
      return "Select tags (${usedTags.length} selected)";
    }
  }
}
