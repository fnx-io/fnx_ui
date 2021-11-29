import 'dart:async';
import 'package:fnx_ui/src/util/async.dart';
import 'package:test/test.dart';

void main() {
  group("FnxStreamDebouncer", () {
    test("delivers only the last value", () async {
      StreamController<int> ctrl = new StreamController<int>(sync: true);
      Stream<int> stream = ctrl.stream;
      FnxStreamDebouncer<int> debouncer = new FnxStreamDebouncer(new Duration(milliseconds: 100), sync: true);
      Stream<int?> t = stream.transform(debouncer);
      ctrl.add(1);
      ctrl.add(2);
      ctrl.add(3);
      int? result = await t.first;
      expect(result, equals(3));
    });

    test("waits at least specified amount of time before it will deliver next value", () async {
      StreamController<int> ctrl = new StreamController<int>(sync: true);
      Stream<int> stream = ctrl.stream;
      Duration duration = new Duration(milliseconds: 100);
      FnxStreamDebouncer<int> debouncer = new FnxStreamDebouncer(duration, sync: true);
      DateTime start = new DateTime.now();
      Stream<int?> t = stream.transform(debouncer);
      ctrl.add(1);
      await t.first;

      DateTime finished = new DateTime.now();

      DateTime shouldTakeAtLeast = start.add(duration);

      int diff = finished.millisecondsSinceEpoch - shouldTakeAtLeast.millisecondsSinceEpoch;

      expect(diff, greaterThanOrEqualTo(0));
    });
  });
}
