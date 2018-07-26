import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/date/fnx_date_picker.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/util/date.dart' as date;
import 'package:fnx_ui/src/validator.dart';

export 'package:fnx_ui/src/components/date/fnx_date_picker.dart';

const CUSTOM_DATE_VALUE_ACCESSOR = const Provider(ngValueAccessor, useExisting: FnxDate, multi: true);

@Component(
  selector: 'fnx-date',
  providers: const [
    CUSTOM_DATE_VALUE_ACCESSOR,
    const Provider(FnxValidatorComponent, useExisting: FnxDate, multi: false),
  ],
  templateUrl: 'fnx_date.html',
  preserveWhitespace: false,
)
class FnxDate extends FnxInputComponent implements OnInit, OnDestroy {
  /// This is the model for the DOM input field, user types here the date and
  /// we try to parse it and sync it to model
  @Output()
  String dateStr = null;

  Control control = null;

  @Input()
  bool required = false;

  @Input()
  bool dateTime = false;

  @Input()
  bool readonly = false;

  @Input()
  bool disabled = false;

  bool _focused = false;

  final StreamController<bool> _openDatePicker = new StreamController();

  @Output()
  Stream<bool> get openDatePicker => _openDatePicker.stream;

  FnxValidatorComponent _inputWrapper;

  FnxDate(@SkipSelf() @Optional() FnxValidatorComponent parent) : super(parent) {
    _inputWrapper = parent;
  }

  set focused(bool focused) {
    _focused = focused;
    if (focused && !isReadonly) {
      _openDatePicker.add(true);
    }
  }

  get focused => _focused;

  bool get active {
    if (dateStr == null) return false;
    if (dateStr.toString().trim().length == 0) return false;
    return true;
  }

  bool get showError => false; //!control.valid && !control.root.pristine;

  bool validFormattedDate = true;

  @override
  ngOnInit() {
    super.ngOnInit();
    setSuggestedErrorMessage(value);
  }

  void setSuggestedErrorMessage(value) {
    if (_inputWrapper != null && _inputWrapper is FnxInput) {
      // TODO: suspicious
      (_inputWrapper as FnxInput).setDefaultErrorMessage = getSuggestedErrorMessage(value);
    }
  }

  String getSuggestedErrorMessage(value) {
    bool valueEmpty = value == null;
    if (!valueEmpty && value is String) {
      valueEmpty = value.isEmpty;
    }
    if (required && valueEmpty) {
      return "Required value, expected format ${applicableFormat.toLowerCase()}";
    } else {
      return "Invalid value, expected format ${applicableFormat.toLowerCase()}";
    }
  }

  /// called when the input field changes
  /// we try to parse date from it and make errors, if the string is not
  /// in correct date format
  onChangeInput(event) {
    this.dateStr = event;

    DateTime parsed;
    try {
      parsed = dateStrToDateTime(dateStr);
      validFormattedDate = true;
    } catch (ex) {
      parsed = null;
      validFormattedDate = false;
    }
    value = parsed;
    setSuggestedErrorMessage(dateStr);
  }

  String get applicableFormat => dateTime ? date.DATETIME_FORMAT : date.DATE_FORMAT;

  void datePicked(DateTime picked) {
    if (picked == null) {
      value = null;
    } else if (value == null || !(value is DateTime)) {
      value = picked;
    } else {
      DateTime original = value as DateTime;
      DateTime newVersion;

      // preserve hours and minute info if we are in date only mode
      int hour = original.hour;
      int minute = original.minute;
      if (dateTime) {
        hour = picked.hour;
        minute = picked.minute;
      }
      if (original.isUtc) {
        newVersion = new DateTime.utc(picked.year, picked.month, picked.day, hour, minute);
      } else {
        newVersion = new DateTime(picked.year, picked.month, picked.day, hour, minute);
      }
      value = newVersion;
    }
    setStrDate(value);
    validFormattedDate = true;
  }

  void setStrDate(DateTime value) {
    dateStr = formatDateTime(value);
  }

  DateTime dateStrToDateTime(String pattern) {
    try {
      if (pattern == null || pattern
          .trim()
          .isEmpty) return null;
      if (dateTime) {
        return date.dateTimeFormat.parse(pattern);
      } else {
        return date.dateFormat.parse(pattern);
      }
    } catch (e) {
      if (pattern.contains(",")) {
        pattern = pattern.replaceAll(",", ".");
        return dateStrToDateTime(pattern);
      }
      if (pattern.contains("/")) {
        pattern = pattern.replaceAll("/", ".");
        return dateStrToDateTime(pattern);
      }
    }
  }

  DateTime tryParseDate(Object o) {
    if (o is DateTime) {
      return o;
    } else {
      return date.parseDate(o);
    }
  }

  String formatDateTime(DateTime value) {
    if (value == null) return null;
    if (dateTime) {
      return date.dateTimeFormat.format(value);
    } else {
      return date.formatDate(value);
    }
  }

  @override
  void writeValue(obj) {
    if (obj is DateTime) {
      super.writeValue(obj);
      setStrDate(obj);
    } else {
      var parsed = tryParseDate(obj);
      super.writeValue(parsed);
      setStrDate(parsed);
    }
  }

  void onFocus() {
    focused = true;
    markAsTouched();
  }

  void onBlur() {
    focused = false;
    if (value != null) {
      setStrDate(value);
    }
  }

  void ensurePickerOpened() {
    markAsTouched();
    if (!isReadonly) {
      _openDatePicker.add(true);
    }
  }

  @override
  bool hasValidValue() {
    bool requiredCheck = true;
    if (required) requiredCheck = value != null;
    return requiredCheck && validFormattedDate;
  }

}

const FNX_DATE_DIRECTIVES = const [FnxDate, FnxDatePicker];
