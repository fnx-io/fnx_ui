import 'package:angular2/core.dart';

typedef bool validatorFunction();

abstract class FnxValidatorComponent {

  bool _touched = false;

  List<FnxValidatorComponent> _validatorChildren = [];

  void markAsTouched() {
    _touched = true;
    _validatorChildren.forEach((FnxValidatorComponent c) => c.markAsTouched());
  }

  bool isValid() {
    return hasValidValue() && hasValidChildren();
  }

  bool isTouchedAndInvalid() {
    return isTouched() && !isValid();
  }

  bool isTouched() {
    if (_touched) return true;
    if (_validatorChildren.isEmpty) return false;
    return _validatorChildren.firstWhere((val) => val.isTouched(), orElse: () => null) != null;
  }

  bool hasValidValue();

  bool hasValidChildren() {
    if (_validatorChildren.isEmpty) return true;
    return _validatorChildren.firstWhere((val) => !val.isValid(), orElse: () => null) == null;
  }

  void registerChild(FnxValidatorComponent child) {
    if (!_validatorChildren.contains(child)) {
      _validatorChildren.add(child);
      if (_touched) {
        child.markAsTouched();
      }
    }
  }

  void deregisterChild(FnxValidatorComponent child) {
    _validatorChildren.remove(child);
  }

}