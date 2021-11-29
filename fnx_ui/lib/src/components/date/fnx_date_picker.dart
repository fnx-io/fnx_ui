import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:fnx_ui/src/components/input/fnx_int.dart';
import 'package:fnx_ui/src/components/input/fnx_text.dart';
import 'package:fnx_ui/src/components/modal/fnx_modal.dart';
import 'package:fnx_ui/src/util/async.dart';
import 'package:fnx_ui/src/util/date.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:fnx_ui/src/util/ui.dart';
import 'package:intl/intl.dart';

@Component(selector: 'fnx-date-picker', templateUrl: 'fnx_date_picker.html', preserveWhitespace: false, directives: const [
  coreDirectives,
  formDirectives,
  FnxText,
  FnxInt
], styles: const [
  ".picker--date td.date-is-empty { cursor: default !important; background: none !important; padding: 5px !important;}",
])
class FnxDatePicker implements OnInit, OnDestroy {
  String componentId = ui.uid('datepicker-');

  /// using this emitter instances of DatePickers broadcast, that they
  /// have been requested to be opened
  static final StreamController<FnxDatePicker> _ON_PICKER_OPENED = new StreamController<FnxDatePicker>.broadcast();
  static Stream<FnxDatePicker> get ON_PICKER_OPENED => _ON_PICKER_OPENED.stream;

  StreamSubscription<FnxDatePicker>? _pickerOpenedSubscription;

  DropdownTracker dropdownTracker = new DropdownTracker();

  bool _shown = false;

  @Input()
  String? label;

  DateTime? _value;
  DateTime? _originalValue;

  @Input()
  bool hourFormat24 = true;
  @Input()
  bool dateTime = false;

  List? days;

  StreamController<bool> _closed = new StreamController();
  @Output()
  Stream<bool> get closed => _closed.stream;

  StreamController<DateTime?> _datePicked = new StreamController();
  @Output()
  Stream<DateTime?> get datePicked => _datePicked.stream;

  @Input()
  Stream<bool>? open;

  StreamSubscription? _openSubscription;

  DateTime today = new DateTime.now();
  String todayString = dateFormat.format(new DateTime.now());

  DateTime? get value => _value;

  @ViewChild("container")
  HtmlElement? container;

  StreamSubscription<MouseEvent>? _globalClicks;

  @ViewChild("dropdown")
  HtmlElement? dropdown;

  late StreamSubscription<KeyboardEvent> keyDownSubscription;

  FnxModal? modal;

  /// Constructor used to create instance of Datepicker.
  FnxDatePicker(@Optional() this.modal) {
    initPicker();
  }

  @Input()
  set value(var date) {
    valueInternal = date;
    _originalValue = _value;
  }

  set valueInternal(var date) {
    if (date != null && !(date is DateTime)) return;
    _value = date as DateTime?;
    valueChanged();
  }

  set shown(bool toShow) {
    bool alreadyShown = _shown;
    this._shown = toShow;
    if (toShow && !alreadyShown) {
      // broadcast, that we are opening this widget
      _ON_PICKER_OPENED.add(this);
    }

    if (shown == true) {
      modal!.activeChilds.add(this);
    } else {
      modal!.activeChilds.remove(this);
    }
  }

  bool get shown => _shown;

  int get year => _value!.year;
  int get month => _value!.month;
  int get day => _value!.day;

  int get hour => _value!.hour;
  int get minute => _value!.minute;

  String? editingTime = null;

  String? get timeToShow {
    if (editingTime != null) return editingTime;
    if (hourFormat24) {
      if (minute < 10) return "$hour:0$minute";
      return "$hour:$minute";
    } else {
      if (minute < 10) return "${hour24ToAmPm(hour)}:0$minute";
      return "${hour24ToAmPm(hour)}:$minute";
    }
  }

  void set timeToShow(String? a) {
    if (_value == null) return;
    if (a == null) return;
    editingTime = a;
    try {
      List<String> p = a.trim().split(":");
      int? h = int.tryParse(p[0]);
      int? m = int.tryParse(p[1]);
      if (h == null) return;
      if (m == null) m = 0;
      valueInternal = new DateTime(
        _value!.year,
        _value!.month,
        _value!.day,
        h,
        m,
      );
      _datePicked.add(_value);
    } catch (e) {}
  }

  AmPm get amPm => amOrPm(hour);

  void valueChanged() {
    initPicker();
  }

  initPicker() {
    if (_value == null) {
      _value = today;
    }
    initPickerModel();
  }

  initPickerModel() {
    DateTime ref = new DateTime.utc(year, month, 1);
    List result = [];
    for (int a = 0; a < 6; a++) {
      result.add([]);
      for (int b = 0; b < 7; b++) {
        result[a].add(" ");
        if (ref.month == month) {
          if (ref.weekday - 1 == b) {
            result[a][b] = ref.day;
            ref = ref.add(new Duration(days: 1));
          }
        }
      }
    }
    days = result;
  }

  bool isSelected(var year, var month, var day) {
    if (_originalValue == null) return false;
    return _originalValue!.year == year && _originalValue!.month == month && _originalValue!.day == day;
  }

  bool isToday(var year, var month, var day) {
    return today.year == year && today.month == month && today.day == day;
  }

  bool isDay(dynamic day) => day is int;

  void pickDay(dynamic year, dynamic month, dynamic day, Event e) {
    e.stopPropagation();
    e.preventDefault();
    if (year is! int || month is! int || day is! int) {
      return;
    }

    _datePicked.add(new DateTime(year, month, day, _value!.hour, _value!.minute));
    if (!dateTime) {
      hidePicker();
    }
  }

  void hidePicker() {
    shown = false;
    _closed.add(true);
  }

  String formatNumber(int num) {
    //if (num == null) return null;
    var formatter = new NumberFormat('00');
    return formatter.format(num);
  }

  void incMinute() {
    addDurationToValue(new Duration(minutes: 1));
  }

  void decMinute() {
    subtractDurationFromValue(new Duration(minutes: 1));
  }

  void incHour() {
    addDurationToValue(new Duration(hours: 1));
  }

  void decHour() {
    subtractDurationFromValue(new Duration(hours: 1));
  }

  void incMonth() {
    changeValueMonth(1);
  }

  void decMonth() {
    changeValueMonth(-1);
  }

  void incYear() {
    changeValueMonth(12);
  }

  void decYear() {
    changeValueMonth(-12);
  }

  void showToday() {
    int? h, m, s, ms = 0;
    bool utc = today.isUtc;
    if (value != null) {
      h = value!.hour;
      m = value!.minute;
      s = value!.second;
      ms = value!.millisecond;
      utc = value!.isUtc;
    }
    valueInternal = dateFrom(today.year, today.month, today.day, h, m, s, ms, utc);
    _datePicked.add(value);
  }

  void changeValueMonth(int by) {
    if (value == null) return;
    //int day = value.day;
    int month = value!.month;
    int year = value!.year;
    int yearsChange = (by / 12).floor();
    int monthsChange = by % 12;

    // we intentionally do not emit datePicked event, since this signals that the picker
    // should rerender, not that new value has been picked
    valueInternal = dateFrom(year + yearsChange, month + monthsChange, 1, value!.hour, value!.minute, value!.second, value!.millisecond, value!.isUtc);
  }

  void addDurationToValue(Duration dur) {
    valueInternal = _value!.add(dur);
    _datePicked.add(_value);
  }

  void subtractDurationFromValue(Duration dur) {
    valueInternal = _value!.subtract(dur);
    _datePicked.add(_value);
  }

  bool get isAm => AmPm.AM == amPm;
  bool get isPm => AmPm.PM == amPm;

  void setPm() {
    var h = hour24ToAmPm(hour)!.hour;
    int convertedHour = hourAmPmTo24(new AmPmHour(h, AmPm.PM));
    valueInternal = setHour(_value!, convertedHour);
    _datePicked.add(_value);
  }

  void setAm() {
    var h = hour24ToAmPm(hour)!.hour;
    int convertedHour = hourAmPmTo24(new AmPmHour(h, AmPm.AM));
    valueInternal = setHour(_value!, convertedHour);
    _datePicked.add(_value);
  }

  void ensureOpened() {
    shown = true;
    dropdownTracker.updatePosition();
    later(dropdownTracker.updatePosition);
  }

  @override
  ngOnInit() {
    _pickerOpenedSubscription = ON_PICKER_OPENED.listen((picker) => somePickerOpened(picker));
    if (open != null) {
      _openSubscription = open!.listen((_) => ensureOpened());
    }
    _globalClicks = document.onClick.listen((event) {
      if (shown != true) return;
      if (ui.isEventFromSubtree(event, container!.parentNode!.parentNode)) return;
      hidePicker();
    });
    dropdownTracker.init(container, dropdown, () => shown = false);

    keyDownSubscription = ui.keyDownEvents.where((KeyboardEvent e) => e.keyCode == KeyCode.ESC).listen((KeyboardEvent e) {
      ui.killEvent(e);
      hidePicker();
    });
  }

  void somePickerOpened(FnxDatePicker picker) {
    // if any other picker has been opened, ensure this one gets closed
    if (picker != this && _shown) {
      hidePicker();
    }
  }

  @override
  ngOnDestroy() {
    if (_openSubscription != null) _openSubscription!.cancel();
    if (_pickerOpenedSubscription != null) _pickerOpenedSubscription!.cancel();
    if (_globalClicks != null) _globalClicks!.cancel();
    dropdownTracker.destroy();
    keyDownSubscription.cancel();
  }

  void killEvent(Event event) {
    ui.killEvent(event);
  }
}
