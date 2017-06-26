import 'package:angular2/angular2.dart';
import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/date/fnx_date_picker.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/util/date.dart' as date;

export 'package:fnx_ui/src/components/date/fnx_date_picker.dart';


const CUSTOM_DATE_VALUE_ACCESSOR = const Provider(  NG_VALUE_ACCESSOR,
                                                    useExisting: FnxDate,
                                                    multi: true);
@Component(
    selector: 'fnx-date',
    providers: const [CUSTOM_DATE_VALUE_ACCESSOR],
    templateUrl: 'fnx_date.html',
    preserveWhitespace: false
)
class FnxDate extends FnxInputComponent implements OnInit, OnDestroy {

  /// This is the model for the DOM input field, user types here the date and
  /// we try to parse it and sync it to model
  @Output() String dateStr = null;
  
  Control control = null;

  @Optional()
  @Input()
  bool required = false;

  @Input()
  bool dateTime = false;

  @Input()
  bool readonly = false;

  bool _focused = false;

  EventEmitter _openDatePicker = new EventEmitter();

  FnxInput _inputWrapper;

  FnxDate(@Optional() FnxInput wrapper, @Optional() FnxForm form): super(form, wrapper) {
    _inputWrapper = wrapper;
  }

  set focused(bool focused) {
    _focused = focused;
    if (focused && !isReadonly) {
      _openDatePicker.emit(true);
    }
  }
  get focused => _focused;

  get openDatePicker => _openDatePicker;

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
    if (_inputWrapper != null) {
      _inputWrapper.setDefaultErrorMessage = getSuggestedErrorMessage(value);
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
      return  "Invalid value, expected format ${applicableFormat.toLowerCase()}";
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

  String get applicableFormat => dateTime ? date.DATETIME_FORMAT: date.DATE_FORMAT;

  void datePicked(DateTime picked) {
    if (picked == null) {
      value = null;
    } else if (value == null || !(value is DateTime)){
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

  @override
  void writeValue(obj) {
    if (obj is DateTime) {
      super.writeValue(obj);
      setStrDate(obj);
    } else {
      var parsed = tryParseDate(obj);
      super.writeValue(parsed);
      if (parsed != null) {
        setStrDate(parsed);
      }
    }
  }

  void onFocus() {
    focused = true;
    markAsTouched();
  }

  void ensurePickerOpened() {
    markAsTouched();
    if (!isReadonly) {
      _openDatePicker.emit(true);
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
