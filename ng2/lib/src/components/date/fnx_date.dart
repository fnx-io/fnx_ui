import 'package:angular2/angular2.dart';
import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
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
    templateUrl: 'fnx_date.html')
class FnxDate extends FnxInputComponent implements OnInit, ControlValueAccessor {

  NgForm formCtrl;

  /// This is the property from the model, we propagate dates from it and
  /// back to it, as user changes them.
  var _value;

  get value => _value;

  /// This is the model for the DOM input field, user types here the date and
  /// we try to parse it and sync it to model
  @Output() String dateStr = null;

  Control control = null;

  @Optional()
  @Input()
  bool required = false;

  @Input()
  bool dateTime = false;

  bool _focused = false;

  EventEmitter _openDatePicker = new EventEmitter();

  var onChange = (_) {};
  var onTouched = (_) {};

  FnxDate(@Optional() FnxInput wrapper): super(wrapper);

  set focused(bool focused) {
    _focused = focused;
    if (focused) {
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

  @override
  ngOnInit() {
    super.ngOnInit();
  }

  /// called when the input field changes
  /// we try to parse date from it and make errors, if the string is not
  /// in correct date format
  onChangeInput(event) {
    this.dateStr = event;

    DateTime parsed;
    try {
      parsed = dateStrToDateTime(dateStr);
      errorStateChange.emit(false);
    } catch (ex) {
      parsed = null;
      String format;
      if (dateTime) {
        format = date.DATETIME_FORMAT;
      } else {
        format = date.DATE_FORMAT;
      }
      errorStateChange.emit("Invalid date, required format ${format.toLowerCase()}");
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
    errorStateChange.emit(false);
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

  void ensurePickerOpened() {
    _openDatePicker.emit(true);
  }
}

const FNX_DATE_DIRECTIVES = const [FnxDate, FnxDatePicker];
