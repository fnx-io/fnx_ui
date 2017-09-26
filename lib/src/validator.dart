import 'dart:async';
import 'package:angular2/core.dart';

///
/// Base class for all components which support validation (extend or mix-in).
///
///
abstract class FnxValidatorComponent implements OnInit, OnDestroy {

  bool _touched = false;

  bool get required; // abstract

  bool get readonly; // abstract

  bool get disabled; // abstract

  List<FnxValidatorComponent> _validatorChildren = [];

  FnxValidatorComponent _parent;
  FnxValidatorComponent get parent => _parent;
  FnxValidatorComponent(@SkipSelf() @Optional() FnxValidatorComponent this._parent);

  @override
  ngOnInit() {
    if (_parent != null) {
      _parent.registerChild(this);
    }
  }

  @override
  ngOnDestroy() {
    if (_parent != null) {
      _parent.deregisterChild(this);
    }
  }

  ///
  /// User interacted with this component.
  ///
  void markAsTouched() {
    if (isReadonly) return;
    _touched = true;
    _validatorChildren.forEach((FnxValidatorComponent c) => c.markAsTouched());
  }

  ///
  /// Remove user interaction flag.
  ///
  void markAsNotTouched() {
    if (isReadonly) return;
    _touched = false;
    _validatorChildren.forEach((FnxValidatorComponent c) => c.markAsNotTouched());
  }

  ///
  /// Component is valid, if it is valid itself (hasValidValue) and has valid children (recursively).
  ///
  bool isValid() {
    return hasValidValue() && hasValidChildren();
  }

  ///
  /// Component is invalid, and also was in interaction with the user,
  /// someone (fnx-input) should display an error message.
  ///
  bool isTouchedAndInvalid() {
    return isTouched() && !isValid();
  }

  ///
  /// Component is considered touched, when it's touched itself, or some of
  /// it's children is touched (recursively).
  ///
  bool isTouched() {
    if (_touched) return true;
    if (_validatorChildren.isEmpty) return false;
    return _validatorChildren.firstWhere((val) => val.isTouched(), orElse: () => null) != null;
  }

  ///
  /// Implement this function.
  ///
  bool hasValidValue();

  bool hasValidChildren() {
    if (_validatorChildren.isEmpty) return true;
    return _validatorChildren.firstWhere((val) => !val.isValid(), orElse: () => null) == null;
  }

  bool hasRequiredChildren() {
    if (_validatorChildren.isEmpty) return false;
    return _validatorChildren.firstWhere((val) => val.required, orElse: () => null) != null;
  }

  bool get isParentReadonly {
    return _parent?.isReadonly == true;
  }

  bool get isReadonly => (readonly ?? false) || isParentReadonly;

  bool get isParentDisabled {
    return _parent?.isDisabled == true;
  }

  bool get isDisabled => (disabled ?? false) || isParentDisabled;

  /// This component has some children, which should be part of this component
  /// validation (i.e. fnx-form has a lot of children, fnx-input has typicaly one)
  void registerChild(FnxValidatorComponent child) {
    if (!_validatorChildren.contains(child)) {
      _validatorChildren.add(child);
      if (_touched) {
        child.markAsTouched();
      }
    }
  }

  ///
  /// Remove children.
  ///
  void deregisterChild(FnxValidatorComponent child) {
    _validatorChildren.remove(child);
  }
}