import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';

@Component(
  selector: 'select-create-showcase',
  template: r'''
  <div>
    <div>
      <button type="submit" 
              class="btn margin--bottom" 
              data-prefix="arrow_back"
              [routerLink]="['Default']"> 
        back to documentation
      </button>
  
    </div>
  
    <div  style="max-width: 60em">
      <fnx-alert type="info">Complex example of special form which allows user to select multiple
          objects from collection and also create new if needed.</fnx-alert>
      <fnx-panel-small>
        <h5 header>Select project members</h5>
  
        <!-- Existing rows Rows -->
        <div *ngFor="let r of members; let c = index; let last = last" class="flex--row margin--small--bottom">
          <span class="char margin--small--right">#{{c+1}}</span>
  
          <p class="item flex--grow flex--shrink margin--small--right">
              {{personsById[r]['name'] + ', ' + personsById[r]['occupation'] + ', ' + personsById[r]['phone']}}
          </p>
          <span class="text--right">
              <button class="btn icon" (click)="removeMember(c)">remove</button>
          </span>
        </div>
  
        <!-- Add new row -->
        <div class="flex--row">
  
          <span class="char margin--right"></span>
  
          <fnx-select [(ngModel)]="members"
                      [multi]="true"
                      [valueDescriptionRenderer]="renderPersonSelectDescription"
                      class="flex--grow flex--shrink">
            <fnx-option *ngFor="let pm of persons"
                        [value]="pm['id']" label="{{pm['name'] + ', ' + pm['occupation'] + ', ' + pm['phone']}}"></fnx-option>
          </fnx-select>
  
          <span class="char">
              or
          </span>
          
          <div>
              <button class="btn" (click)="openCreateModal = true">create a new person</button>
          </div>
          
        </div>
  
      </fnx-panel-small>
  
      <p class="padding f-monospace">
          Debug: {{members}}
      </p>
  
  
      <!--
         Modal with form.
  
         Notice how form wraps the modal and not the other way around.
         This allows me to place submit bar into standard modal footer.
      -->
      <fnx-form (submit)="createNewPerson()">
        <fnx-modal *ngIf="openCreateModal" (close)="openCreateModal = false">
          <h3 header>Create a new member</h3>
          <div main>
  
            <fnx-input label="Name" errorMessage="Mandatory value">
                <fnx-text [(ngModel)]="createPerson['name']" [required]="true"></fnx-text>
            </fnx-input>
  
            <fnx-input label="Occupation" errorMessage="Mandatory value">
                <fnx-text [(ngModel)]="createPerson['occupation']" [required]="true"></fnx-text>
            </fnx-input>
  
            <fnx-input label="Phone" errorMessage="Mandatory value">
                <fnx-text [(ngModel)]="createPerson['phone']" [required]="true"></fnx-text>
            </fnx-input>
  
  
            <p class="padding f-monospace">
                Debug: {{createPerson}}
            </p>
  
          </div>
          <fnx-submit-bar footer>
            <button class="btn" (click)="openCreateModal = false">close</button>
          </fnx-submit-bar>
        </fnx-modal>
      </fnx-form>
    </div>
  </div>
  ''',
)
class SelectCreateShowcase {

  int id = 6;

  FnxApp app;

  List persons = [
    {"id": 1, "name": "John Smith", "occupation": "warrior", "phone": "4235532423"},
    {"id": 2, "name": "Kevin Baker", "occupation": "mage", "phone": "936246323"},
    {"id": 3, "name": "Emma Govinda", "occupation": "paladin", "phone": "423434334"},
    {"id": 4, "name": "Alice Cooper", "occupation": "thief", "phone": "967423514"},
    {"id": 5, "name": "George Holmes", "occupation": "detective", "phone": "4265321456"},
  ];

  Map<int, Map> personsById = {};

  List<int> members = []; // first element - empty, waiting for selection

  Map createPerson = {};

  SelectCreateShowcase(this.app) {
    persons.forEach((Map member) {
      personsById[member['id']] = member;
    });
  }

  bool openCreateModal = false;

  void removeMember(int index) {
    members.removeAt(index);
  }

  String renderPersonSelectDescription() {
    if (members.isEmpty) {
      return "Select a person ...";
    } else {
      return "Select a person (${members.length} selected)";
    }
  }

  void createNewPerson() {
    // send to server, validate, receive id
    createPerson["id"] = id++;

    // add to local copies
    persons.add(createPerson);
    personsById[createPerson["id"]] = createPerson;

    // insert as the last value
    members.add(createPerson["id"]);

    // rest form
    createPerson = {};

    // hide form
    openCreateModal = false;
  }
}
