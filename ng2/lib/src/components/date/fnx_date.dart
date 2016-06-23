import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:fnx_ui/src/util/date.dart' as date;
import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:angular2/src/common/forms/directives/validators.dart';

import 'package:fnx_ui/src/components/date/fnx_date_picker.dart';
export 'package:fnx_ui/src/components/date/fnx_date_picker.dart';


const CUSTOM_DATE_VALUE_ACCESSOR = const Provider(  NG_VALUE_ACCESSOR,
                                                    useExisting: FnxDate,
                                                    multi: true);

@Component(
    selector: 'fnx-date',
    providers: const [CUSTOM_DATE_VALUE_ACCESSOR],
    templateUrl: 'fnx_date.html')
class FnxDate implements OnInit, ControlValueAccessor {

  String id = ui.uid('date-');

  @Input()
  String label;

  @Input()
  String errorMessage;

  NgForm formCtrl;

  /// This is the property from the model, we propagate dates from it and
  /// back to it, as user changes them.
  var _value;

  get value => _value;

  /// This is the model for the DOM input field, user types here hers name and
  /// we try to parse it and sync it to model
  @Output() String dateStr = null;

  Control control = null;

  @Optional()
  @Input()
  bool required = false;

  @Input()
  bool dateTime = false;

  bool parseDateError = false;
  bool _focused = false;
  @Output() bool datePickerShown = false;

  var onChange = (_) {};
  var onTouched = (_) {};

  set focused(bool focused) {
    _focused = focused;
    if (focused) {
      datePickerShown = true;
    }
  }
  get focused => _focused;

  bool get active {
    if (dateStr == null) return false;
    if (dateStr.toString().trim().length == 0) return false;
    return true;
  }

  bool get showError => false; //!control.valid && !control.root.pristine;

  @override
  ngOnInit() {
    /*List<ValidatorFn> validators = [];
    validators.add((AbstractControl) {
      if (parseDateError) {
        return {'parseDateError': true};;
      } else {
        return null;
      }
    });
    if (required) {
      validators.add(Validators.required);
    }
    control = new Control('', Validators.compose(validators));
    this.formCtrl.control..addControl(this.inputField, control);*/
  }

  /// called when the input field changes
  /// we try to parse date from it and make errors, if the string is not
  /// in correct date format
  onChangeInput(event) {
    this.dateStr = event;

    DateTime parsed;
    try {
      parsed = dateStrToDateTime(dateStr);
      errorMessage = null;
      parseDateError = false;
    } catch (ex, strace) {
      parsed = null;
      parseDateError = true;
      String format;
      if (dateTime) {
        format = date.DATETIME_FORMAT;
      } else {
        format = date.DATE_FORMAT;
      }
      errorMessage = "Invalid date, required format ${format.toLowerCase()}";
    }
    _value = parsed;
    onChange(_value);
  }

  void datePicked(DateTime picked) {
    if (picked == null) {
      _value = null;
    } else if (_value == null || !(_value is DateTime)){
      _value = picked;
    } else {
      DateTime original = _value as DateTime;
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
      _value = newVersion;
    }
    setStrDate(_value);
    onChange(_value);
  }

  void setStrDate(DateTime value) {
    dateStr = formatDateTime(value);
  }

  DateTime dateStrToDateTime(String pattern) {
    if (pattern == null || pattern.trim().isEmpty) return null;
    if (dateTime) {
      return date.dateTimeFormat.parse(pattern);
    } else {
      return date.dateFormat.parse(pattern);
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

  void kbMaybeClosePicker(int keyCode) {
    if (keyCode == 27) {
      datePickerShown = false;
    }
  }

  @override
  void registerOnChange(fn) {
    onChange = fn;
  }

  @override
  void registerOnTouched(fn) {
    onTouched = fn;
  }

  @override
  void writeValue(obj) {
    if (obj is DateTime) {
      _value = obj;
      setStrDate(obj);
    } else {
      var parsed = tryParseDate(obj);
      _value = parsed;
      if (parsed != null) {
        setStrDate(parsed);
        onChange(parsed);
      }
    }
  }
}

const FNX_DATE_DIRECTIVES = const [FnxDate, FnxDatePicker];
