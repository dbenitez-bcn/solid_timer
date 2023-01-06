import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:solid_timer/bloc/status.dart';
import 'package:solid_timer/domain/datasource/configuration_repository.dart';
import 'package:solid_timer/domain/datasource/timer_repository.dart';
import 'package:solid_timer/domain/models/timer.dart';

import '../domain/models/app_state.dart';

class SolidTimerBloc extends InheritedWidget {
  final TimerRepository _timerRepository;
  final ConfigurationRepository _configurationRepository;
  final _statusController = StreamController<Status>.broadcast();
  final _timersController = StreamController<List<Timer>>();
  final _soundController = StreamController<bool>();
  final _infiniteController = StreamController<bool>();
  final _selectedTimerController = StreamController<Timer>.broadcast();
  final AppState _appState;

  SolidTimerBloc(
      this._timerRepository, this._configurationRepository, this._appState,
      {Key? key, child})
      : super(key: key, child: child ?? Container()) {
    _statusController.add(_appState.status);
    _timersController.add(_appState.timersList);
    _selectedTimerController.add(_appState.lastSelectedTimer);
    _soundController.add(_appState.isSoundEnabled);
    _infiniteController.add(_appState.isInfiniteRoundsEnabled);
  }

  Stream<Status> get status => _statusController.stream;

  Stream<List<Timer>> get timers => _timersController.stream;

  Stream<Timer> get selectedTimer => _selectedTimerController.stream;

  Stream<bool> get soundStream => _soundController.stream;

  Stream<bool> get infiniteRoundsStream => _infiniteController.stream;

  Timer get currentTimer => _appState.lastSelectedTimer;

  bool get isSoundEnabled => _appState.isSoundEnabled;

  bool get isInfiniteRoundsEnabled => _appState.isInfiniteRoundsEnabled;

  void play() {
    _statusController.add(Status.playing);
  }

  void stop() {
    _statusController.add(Status.ready);
  }

  void pause() {
    _statusController.add(Status.waiting);
  }

  void loadTimers() async {
    _timersController.add(await _timerRepository.getAll());
    select(await _timerRepository.getLastSelectedTimer() ?? Timer(1, 30));
  }

  void addTimer(int seconds) async {
    Timer timer = await _timerRepository.create(seconds: seconds);
    loadTimers();
    select(timer);
  }

  void remove(int id) async {
    await _timerRepository.deleteBy(id: id);
    loadTimers();
  }

  void select(Timer newTimer) async {
    _appState.lastSelectedTimer = newTimer;
    var timer = await _timerRepository.updateLastSelectedTimer(newTimer);
    _selectedTimerController.add(timer);
  }

  Future<void> toggleSound() async {
    _appState.isSoundEnabled = !_appState.isSoundEnabled;
    await _configurationRepository.setIsSoundEnabled(_appState.isSoundEnabled);
    _soundController.add(_appState.isSoundEnabled);
  }

  Future<void> toggleInfinite() async {
    _appState.isInfiniteRoundsEnabled = !_appState.isInfiniteRoundsEnabled;
    await _configurationRepository.setIsInfiniteRoundEnabled(_appState.isInfiniteRoundsEnabled);
    _infiniteController.add(_appState.isInfiniteRoundsEnabled);
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
