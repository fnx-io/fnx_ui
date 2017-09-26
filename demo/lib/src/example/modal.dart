import 'package:angular2/core.dart';

@Component(
  selector: 'modal-example',
  template: '''
  <documentation [componentTag]="'fnx-modal'"></documentation>

  <h1>Demo</h1>

  <demo label="Toggle modal">
    <button class="btn" type="button" (click)="modalActive = !modalActive">Toggle modal</button>
  </demo>

  <fnx-modal *ngIf="modalActive == true" (close)="modalActive = false">
    <h3 header>Heading</h3>

    <div main>Content of modal</div>
  </fnx-modal>
  ''',
)
class ModalExample {
  bool modalActive = false;
}
