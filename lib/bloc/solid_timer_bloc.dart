import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:solid_timer/bloc/status.dart';
import 'package:solid_timer/domain/datasource/configuration_repository.dart';
import 'package:solid_timer/domain/datasource/timer_repository.dart';
import 'package:solid_timer/domain/models/solid_timer.dart';

import '../domain/models/app_state.dart';

class SolidTimerBloc extends InheritedWidget {
  final TimerRepository _timerRepository;
  final ConfigurationRepository _configurationRepository;
  final _statusController = StreamController<Status>.broadcast();
  final _timersController = StreamController<List<SolidTimer>>.broadcast();
  final _soundController = StreamController<bool>();
  final _selectedTimerController = StreamController<SolidTimer>.broadcast();
  final _pageController = StreamController<int>.broadcast();
  final AppState _appState;

  SolidTimerBloc(
      this._timerRepository, this._configurationRepository, this._appState,
      {Key? key, child})
      : super(key: key, child: child ?? Container()) {
    _statusController.add(_appState.status);
    _timersController.add(_appState.timersList);
    _selectedTimerController.add(_appState.lastSelectedTimer);
    _soundController.add(_appState.isSoundEnabled);
    _pageController.add(_appState.pageIndex);
  }

  Stream<Status> get status => _statusController.stream;

  Stream<List<SolidTimer>> get timers => _timersController.stream;

  Stream<SolidTimer> get selectedTimer => _selectedTimerController.stream;

  Stream<bool> get soundStream => _soundController.stream;

  Stream<int> get pageStream => _pageController.stream;

  SolidTimer get currentTimer => _appState.lastSelectedTimer;

  bool get isSoundEnabled => _appState.isSoundEnabled;

  int get currentPage => _appState.pageIndex;

  Status get currentStatus => _appState.status;

  void play() {
    _appState.status = Status.playing;
    _statusController.add(Status.playing);
  }

  void stop() {
    _appState.status = Status.ready;
    _statusController.add(Status.ready);
  }

  void pause() {
    _appState.status = Status.waiting;
    _statusController.add(Status.waiting);
  }

  void loadTimers() async {
    _timersController.add(await _timerRepository.getAll());
    select(await _timerRepository.getLastSelectedTimer() ?? SolidTimer(1, 30, null, null));
  }

  void addTimer(int work, int? rest, int? rounds) async {
    SolidTimer timer = await _timerRepository.create(work, rest, rounds);
    loadTimers();
    select(timer);
  }

  void remove(int id) async {
    await _timerRepository.deleteBy(id: id);
    loadTimers();
  }

  void select(SolidTimer newTimer) async {
    _appState.lastSelectedTimer = newTimer;
    var timer = await _timerRepository.updateLastSelectedTimer(newTimer);
    _selectedTimerController.add(timer);
  }

  void updatePage(int index){
    _pageController.add(index);
  }

  Future<void> toggleSound() async {
    _appState.isSoundEnabled = !_appState.isSoundEnabled;
    await _configurationRepository.setIsSoundEnabled(_appState.isSoundEnabled);
    _soundController.add(_appState.isSoundEnabled);
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
