import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:solid_timer/src/bloc/status.dart';
import 'package:solid_timer/src/domain/datasource/timer_repository.dart';
import 'package:solid_timer/src/domain/models/timer.dart';

class SolidTimerBloc extends InheritedWidget {
  final TimerRepository _repository;
  final _statusController = StreamController<Status>();
  final _timersController = StreamController<List<Timer>>();

  SolidTimerBloc(this._repository, {Key? key, child})
      : super(key: key, child: child ?? Container()) {
    _statusController.add(Status.ready);
    _timersController.add([]);
  }

  get status => _statusController.stream;

  get timers => _timersController.stream;

  void play() {
    _statusController.add(Status.playing);
  }

  void stop() {
    _statusController.add(Status.ready);
  }

  void pause() {
    _statusController.add(Status.waiting);
  }

  void load() async {
    _timersController.add(await _repository.getAll());
  }

  void addTimer(int seconds) async{
    await _repository.create(seconds: seconds);
    load();
  }

  void remove(int id) async {
    await _repository.deleteBy(id: id);
    load();
  }

  static SolidTimerBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SolidTimerBloc>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  void dispose() {
    _statusController.close();
    _timersController.close();
  }
}
