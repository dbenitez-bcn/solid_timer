import 'package:flutter_test/flutter_test.dart';
import 'package:solid_timer/src/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/src/bloc/status.dart';

void main() {

  test("Initial status should be ready", () {
    var sut = SolidTimerBloc();
    expect(sut.status, emitsInOrder([Status.ready]));
  });

  test("When play should change to playing", () {
    var sut = SolidTimerBloc();

    sut.play();

    expect(sut.status, emitsInOrder([Status.ready, Status.playing]));
  });

  test("When stop should change to ready", () {
    var sut = SolidTimerBloc();

    sut.stop();

    expect(sut.status, emitsInOrder([Status.ready, Status.ready]));
  });

  test("When pause should change to waiting", () {
    var sut = SolidTimerBloc();

    sut.pause();

    expect(sut.status, emitsInOrder([Status.ready, Status.waiting]));
  });
}