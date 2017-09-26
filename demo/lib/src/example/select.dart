import 'package:angular2/core.dart';

@Component(
  selector: 'select-example',
  template: '''
  <documentation [componentTag]="'fnx-select'"></documentation>

  <h2>Demo</h2>

  <demo header="Standalone">
    <fnx-select>
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo header="Required">
    <fnx-select [required]="true">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo header="Readonly">
    <fnx-select [readonly]="true">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo header="Always show filter">
    <fnx-select [alwaysShowFilter]="true">
      <fnx-option value="one" label="one"></fnx-option>
      <fnx-option value="two" label="two"></fnx-option>
    </fnx-select>
  </demo>

  <demo header="Never show filter">
    <fnx-select [neverShowFilter]="true">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo header="Nullable true">
    <fnx-select [nullable]="true">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo header="Nullable false">
    <fnx-select [nullable]="false">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo header="Multiselect">
    <fnx-select [multi]="true">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo header="Labels 1">
    <fnx-select selectionEmptyLabel="Select an option" optionsEmptySearchLabel="No option found." filterPlaceholder="Search...">
      <fnx-option *ngFor="let option of options" [label]="option" [value]="option"></fnx-option>
    </fnx-select>
  </demo>

  <demo header="Labels 2">
    <fnx-select selectionEmptyLabel="Select an option" optionsEmptyLabel="No options...">
    </fnx-select>
  </demo>
  ''',
)
class SelectExample {
  List<String> options = ['Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon', 'Zeta', 'Eta', 'Theta', 'Iota', 'Kappa', 'Lambda'];
}
