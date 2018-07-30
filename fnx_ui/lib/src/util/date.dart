import 'package:intl/intl.dart';

enum AmPm {
  AM, PM
}

AmPm amOrPm(int hour) {
  if (hour >= 12) {
    return AmPm.PM;
  } else {
    return AmPm.AM;
  }
}

class AmPmHour {
  final int hour;
  final AmPm amPm;

  AmPmHour(this.hour, this.amPm);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is AmPmHour &&
        this.hour == other.hour &&
        this.amPm == other.amPm;
  }

  @override
  int get hashCode {
    return hour.hashCode ^ amPm.hashCode;
  }

  @override
  String toString() {
    return '$hour $amPm';
  }
}

AmPmHour hour24ToAmPm(int hour) {
  if (hour == null) hour = 0;
  if (hour < 0 ) return null;
  if (hour < 1) return new AmPmHour(12, AmPm.AM);
  if (hour < 12) return new AmPmHour(hour, AmPm.AM);
  if (hour == 12) return new AmPmHour(12, AmPm.PM);
  if (hour < 24) return new AmPmHour(hour - 12, AmPm.PM);

  return null;
}

int hourAmPmTo24(AmPmHour hour) {
  if (hour == null) return null;
  if (hour.amPm == AmPm.AM && hour.hour == 12) {
    return 0;
  } else if (hour.amPm == AmPm.AM) {
    return hour.hour;
  } else if (hour.amPm == AmPm.PM && hour.hour == 12) {
    return 12;
  } else {
    return hour.hour + 12;
  }
}

final String ISO_FORMAT = "yyyy-MM-dd'T'HH:mm:ssZ";
final String DATE_FORMAT = 'dd.MM.yyyy';
final String DATETIME_FORMAT = 'dd.MM.yyyy HH:mm';

final DateFormat dateFormat = new DateFormat(DATE_FORMAT);
final DateFormat dateTimeFormat = new DateFormat(DATETIME_FORMAT);
final DateFormat isoFormat = new DateFormat(ISO_FORMAT);


/// From given input tries to parse a DateTime instance.
/// Only String and DateTime objects are supported parameter types.
/// Returns null, if the object is null, not supported parameter type,
/// or the date couldn't be parsed.
DateTime parseDate(Object o) {
  if (o is DateTime) return o;
  if (!(o is String)) return null;
  String str = o as String;
  bool isUtc = str.contains("Z");
  try {
    return isoFormat.parse(o, isUtc).toLocal();
  } catch (ex, strace) {
    try {
      return dateFormat.parse(o, isUtc).toLocal();
    } catch (ex, strace) {
      try {
        return DateTime.parse(o);
      } catch (ex, strace) {
        return null;
      }
    }
  }
}
String formatWith(DateFormat dateFormat, DateTime d) {
  if (d == null || dateFormat == null) return null;
  return dateFormat.format(d);
}

String formatDate(DateTime d) {
  return formatWith(dateFormat, d);
}

String formatDateTime(DateTime d) {
  return formatWith(dateTimeFormat, d);
}

String formatIsoDate(DateTime d) {
  return formatWith(isoFormat, d);
}

DateTime setHour(DateTime d, int hour) {
  return dateFrom(d.year, d.month, d.day, hour, d.minute, d.second, d.millisecond, d.isUtc);
}

DateTime dateFrom(int year, int month, int day, int hour, int minute, int second, int millisecond, bool utc) {
  if (utc) {
    return new DateTime.utc(year, month, day, hour, minute, second, millisecond);
  } else {
    return new DateTime(year, month, day, hour, minute, second, millisecond);
  }
}
