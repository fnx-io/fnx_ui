import "package:test/test.dart";

import 'package:fnx_ui/src/util/date.dart';

void main() {
  var h12 = new AmPmHour(12, AmPm.PM);
  var h0 = new AmPmHour(12, AmPm.AM);
  var h23 = new AmPmHour(11, AmPm.PM);
  test('Converting hours bettween AM/PM and 24h format works', () {
    expect(hour24ToAmPm(12), h12);
    expect(hour24ToAmPm(0), h0);
    expect(hour24ToAmPm(23), h23);
  });

  test('Converting hours bettween 24h and AM/PM format works', () {
    expect(hourAmPmTo24(h12), 12);
    expect(hourAmPmTo24(h0), 0);
    expect(hourAmPmTo24(h23), 23);
  });
}
