import 'dart:async';
import 'dart:html';

import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;

@Component(
  selector: 'wizard-showcase',
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

  <div style="max-width: 60em">

    <fnx-alert type="info">This is a very complicated lorem ipsum proces. Lorem ipsum dolor sit amet, consectetur adipisicing elit.
        Deserunt id incidunt itaque iusto laudantium libero minus, natus, numquam odit quam quas sapiente tenetur.
        Corporis, distinctio ipsam modi nobis quo veniam?</fnx-alert>

    <fnx-form (submit)="nextStep()" #wizardForm>

      <h3>Step {{step + 1}}/{{maxStep + 1}}</h3>

      <div *ngIf="step == 0">
        <p>Ready when you are, hit Next.</p>
      </div>

      <div *ngIf="step == 1">
        <p>Please fill out this important field.</p>
        <fnx-input label="Your first value" errorMessage="This is mandatory">
          <fnx-text [(ngModel)]="entity['first']" [required]="true"></fnx-text>
        </fnx-input>
      </div>

      <div *ngIf="step == 2">
        <p>This is also very important.</p>
        <fnx-input label="Your second value" errorMessage="This is mandatory">
          <fnx-text [(ngModel)]="entity['second']" [required]="true"></fnx-text>
        </fnx-input>
      </div>

      <div *ngIf="step == 3">
        <p>This is useless, but you have to fill it.</p>
        <fnx-input label="Your third value" errorMessage="This is mandatory">
          <fnx-text [(ngModel)]="entity['third']" [required]="true"></fnx-text>
        </fnx-input>
      </div>

      <div *ngIf="step == 4">
        <p>Great job my friend. Ready to save?</p>

        <p class="margin--vertical f-monospace">
            Debug: {{entity}}
        </p>
      </div>

      <fnx-submit-bar label="Next">
          <button class="btn" (click)="prevStep($event)" *ngIf="step > 0">back</button>
      </fnx-submit-bar>
    </fnx-form>
  </div>
</div>  
  ''',
)
class WizardShowcase {
  FnxApp app;

  @ViewChild("wizardForm")
  FnxForm wizardForm;

  int step = 0;
  static int stepCount = 5;
  int maxStep = stepCount - 1; // cannot be static, wouldn't be accessible from component

  Map entity = {};

  WizardShowcase(this.app);

  Future<Null> nextStep() async {
    if (step == maxStep) {
      await app.alert("Saved, thank you!");
      entity = {};
      step = 0;
    } else {
      // becouse othewise would be all elements in the form marked as touched after first step
      // and their errors would be highlighted on UI
      wizardForm.markAsNotTouched();
      step++;
    }
  }

  void prevStep(Event event) {
    ui.killEvent(event);
    if (step > 0) {
      step--;
    }
  }
}
