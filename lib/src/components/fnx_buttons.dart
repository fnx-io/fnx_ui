import 'package:angular2/angular2.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'dart:html';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/validator.dart';

@Component(
    selector: 'fnx-submit-bar',
    template: r'''
<div class="buttonbar">
  <a *ngIf="back" href="#" class="btn " (click)="goBack($event)" data-prefix="arrow_back">{{ goBackLabel }}</a>
  <span class="spacer"></span>
  <button type="submit" class="btn bg--important" attr.data-prefix="{{formValid ? 'check' : 'not_interested'}}">
    {{ label }}
  </button>
</div>
''')
class FnxSubmitBar {

  @Input() String label = "Submit";
  @Input() String goBackLabel = "Back";
  @Input() bool back = false;

  final FnxForm _form;

  FnxSubmitBar(this._form);

  bool get formValid {
    if (_form == null) return true;
    return _form.isValid();
  }

  void goBack(Event event) {
    ui.killEvent(event);
    window.history.back();
  }
}

const FNX_BUTTON_DIRECTIVES = const [FnxSubmitBar];