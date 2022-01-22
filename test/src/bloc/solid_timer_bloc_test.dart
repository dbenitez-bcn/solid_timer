import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solid_timer/src/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/src/bloc/status.dart';

void main() {

  test("Initial status should be ready", () {
    var sut = SolidTimerBloc(child: Container());
    expect(sut.status, emitsInOrder([Status.ready]));
  });

  test("When play should change to playing", () {
    var sut = SolidTimerBloc(child: Container());

    sut.play();

    expect(sut.status, emitsInOrder([Status.ready, Status.playing]));
  });

  test("When stop should change to ready", () {
    var sut = SolidTimerBloc(child: Container());

    sut.stop();

    expect(sut.status, emitsInOrder([Status.ready, Status.ready]));
  });

  test("When pause should change to waiting", () {
    var sut = SolidTimerBloc(child: Container());

    sut.pause();

    expect(sut.status, emitsInOrder([Status.ready, Status.waiting]));
  });
}