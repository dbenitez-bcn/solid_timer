import 'package:flutter_test/flutter_test.dart';
import 'package:solid_timer/src/domain/models/timer.dart';

void main() {
  group("Timer", () {
    group("clock format", () {
      var inputToExpected = {
        Timer(0, 60): "01:00",
        Timer(0, 90): "01:30",
        Timer(0, 12): "00:12",
        Timer(0, 300): "05:00",
        Timer(0, 605): "10:05",
      };

      inputToExpected.forEach((timer, expected) {
        test("Should format the time", () {
          expect(timer.toClockFormat(), expected);
        });
      });
    });
  });
}
