@HtmlImport("fnx_validator.html")
library fnx_ui.fnx_validator;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/paper_ripple.dart';
import 'package:polymer_elements/paper_material.dart';

import '../fnx_ui.dart';
import 'package:polymer_elements/paper_checkbox.dart';
import 'package:polymer_elements/paper_input.dart';
import '../ui/fnx_field.dart';

const int VALIDATION_DELAY = 500;

@PolymerRegister("fnx-validator")
class FnxValidator extends PolymerElement {

  @property
  bool isValid = null;


  FnxValidator.created() : super.created();

  /*

  Bummer. Blur doesn't bubble.

  @Listen("blur")
  void listenBlur(Event e, _) {
    print("Detected blur on ${e}");
    _validateLater(e.target);
  }
  */

  @Listen("input")
  void listenInput(Event e, _) {
    print(elementToString(this)+" Detected input on ${elementToString(e.target)}");
    _validateLater(e.target);
  }

  @Listen("change")
  void listenChange(Event e, _) {
    print(elementToString(this)+" Detected change on ${elementToString(e.target)}");
    _validateLater(e.target);
  }

  @Listen("focusout")
  void listenFocusout(Event e, _) {
    print(elementToString(this)+" Detected focusout on ${elementToString(e.target)}");
    _validateLater(e.target, 50);
  }

  @Listen("submit")
  void validateAll(Event e, _) {
    print(elementToString(this)+" Validating all");
  }

  void _validateLater(HtmlElement e, [int waitTime = VALIDATION_DELAY]) {
    debounce("validate-${e.hashCode}", ()=>_validateElement(e), waitTime:waitTime);
  }

  bool _validateElement(HtmlElement e) {
    print(elementToString(this)+" Validating ${elementToString(e)}");

    FnxField parentField = findParentField(e, PaperInput, notDeeperThen: this);
    print(parentField);

    String errorMessage = null;

    if (e is PaperCheckbox) {
      //(e as PaperCheckbox).validate();

    } else if (e is InputElement) {
      if (!(e as InputElement).checkValidity()) {
        errorMessage = (e as InputElement).validationMessage;
      }
    }

    // fury dalsich variant

    if (parentField != null) {
      parentField.set("error", errorMessage);
    }

    return errorMessage == null;
  }

}
