import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solid_timer/src/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/src/bloc/status.dart';
import 'package:solid_timer/src/domain/datasource/timer_repository.dart';
import 'package:solid_timer/src/domain/models/timer.dart';

import '../TimerFixture.dart';
import 'solid_timer_bloc_test.mocks.dart';

@GenerateMocks([TimerRepository])
void main() {
  group("Solid timer bloc", () {
    TimerRepository repository = MockTimerRepository();
    setUp(() {
      when(repository.getAll()).thenAnswer((_) async => []);
      when(repository.getLastSelectedTimer()).thenAnswer((_) async => null);
    });

    tearDown(() {
      reset(repository);
    });

    group("Status", () {
      test("Initial status should be ready", () {
        var sut = SolidTimerBloc(repository);
        expect(sut.status, emitsInOrder([Status.ready]));
      });

      test("When play should change to playing", () {
        var sut = SolidTimerBloc(repository);

        sut.play();

        expect(sut.status, emitsInOrder([Status.ready, Status.playing]));
      });

      test("When stop should change to ready", () {
        var sut = SolidTimerBloc(repository);

        sut.stop();

        expect(sut.status, emitsInOrder([Status.ready, Status.ready]));
      });

      test("When pause should change to waiting", () {
        var sut = SolidTimerBloc(repository);

        sut.pause();

        expect(sut.status, emitsInOrder([Status.ready, Status.waiting]));
      });
    });

    group("Timers", () {
      test("Should emit all times when loaded", () async {
        var timersList = [A_TIMER];
        when(repository.getAll()).thenAnswer((_) async => timersList);
        SolidTimerBloc sut = SolidTimerBloc(repository);

        sut.load();

        expect(sut.timers, emitsInOrder([[], timersList]));
      });

      test("Given a seconds should add a new timer", () async {
        SolidTimerBloc sut = SolidTimerBloc(repository);
        when(repository.create(seconds: 10)).thenAnswer((_) async => A_TIMER);

        sut.addTimer(10);
        verify(repository.create(seconds: 10));
        expect(sut.timers, emitsInOrder([[], []]));
      });

      test("Given an id should remove a timer", () async {
        SolidTimerBloc sut = SolidTimerBloc(repository);

        sut.remove(1);

        verify(repository.deleteBy(id: 1));
        expect(sut.timers, emitsInOrder([[], []]));
      });
    });

    group("Selected timer", () {
      test("Should get the last selected value when loaded", () async {
        when(repository.getLastSelectedTimer())
            .thenAnswer((_) async => A_TIMER);

        SolidTimerBloc sut = SolidTimerBloc(repository);

        sut.load();

        expect(sut.selectedTimer, emitsInOrder([A_TIMER]));
      });

      test("When there is no last selected timer should get a default value",
          () async {
        when(repository.getLastSelectedTimer()).thenAnswer((_) async => null);

        SolidTimerBloc sut = SolidTimerBloc(repository);

        sut.load();

        expect(sut.selectedTimer, emitsInOrder([Timer(1, 30)]));
      });

      test("should select the given timer ", () {
        final newTimer = Timer(2, 10);
        final expectedTimer = Timer(1, 10);
        SolidTimerBloc sut = SolidTimerBloc(repository);
        when(repository.updateLastSelectedTimer(newTimer))
            .thenAnswer((_) async => expectedTimer);
        sut.select(newTimer);
        expect(sut.selectedTimer, emitsInOrder([expectedTimer]));
      });
    });
  });
}
