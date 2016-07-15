import 'package:angular2/angular2.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:html';

@Component(
    selector: 'fnx-submit-bar',
    template: r'''
<div class="buttonbar">
  <a *ngIf="back" href="#" class="btn " (click)="goBack($event)"><fnx-icon type="arrow_back"></fnx-icon>{{ goBackLabel }}</a>
  <span class="spacer"></span>
  <button type="submit" class="btn bg--important">
    {{ label }}
    <fnx-icon *ngIf="formValid" type="check"></fnx-icon>
    <fnx-icon *ngIf="!formValid" type="not_interested"></fnx-icon>
  </button>
</div>
''')
class FnxSubmitBar {

  @Input() String label = "Submit";
  @Input() String goBackLabel = "Back";
  @Input() bool back = false;

  final NgForm _form;

  FnxSubmitBar(@Optional() this._form);

  bool get formValid {
    if (_form == null) return true;
    return _form.control.valid;
  }

  void goBack(Event event) {
    ui.killEvent(event);
    window.history.back();
  }
}

const FNX_BUTTON_DIRECTIVES = const [FnxSubmitBar];