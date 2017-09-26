import 'package:angular2/core.dart';

@Component(
  selector: 'select-example',
  template: '''
  <documentation [componentTag]="'fnx-select'"></documentation>

  <h1>Demo</h1>

  <demo label="Standalone">
    <fnx-select>
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo label="Required">
    <fnx-select [required]="true">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo label="Readonly">
    <fnx-select [readonly]="true" [ngModel]="options?.first">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo label="Always show filter">
    <fnx-select [alwaysShowFilter]="true">
      <fnx-option value="one" label="one"></fnx-option>
      <fnx-option value="two" label="two"></fnx-option>
    </fnx-select>
  </demo>

  <demo label="Never show filter">
    <fnx-select [neverShowFilter]="true">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo label="Nullable true">
    <fnx-select [nullable]="true">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo label="Nullable false">
    <fnx-select [nullable]="false">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo label="Multiselect">
    <fnx-select [multi]="true">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo label="Labels 1">
    <fnx-select selectionEmptyLabel="Select an option" optionsEmptySearchLabel="No option found." filterPlaceholder="Search...">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo label="Labels 2">
    <fnx-select selectionEmptyLabel="Select an option" optionsEmptyLabel="No options...">
    </fnx-select>
  </demo>
  ''',
)
class SelectExample {
  List<String> options = ['Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon', 'Zeta', 'Eta', 'Theta', 'Iota', 'Kappa', 'Lambda'];
}
