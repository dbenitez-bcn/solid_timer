import 'package:flutter_test/flutter_test.dart';
import 'package:solid_timer/src/utils/solid_timer_utils.dart';

void main() {
  group("Timer format", () {
    var inputToExpected = {
      formatTime(60): "01:00",
      formatTime(90): "01:30",
      formatTime(12): "00:12",
      formatTime(300): "05:00",
      formatTime(605): "10:05",
    };

    inputToExpected.forEach((input, expected) {
      test("$input -> $expected", () {
        expect(input, expected);
      });
    });
  });
}
