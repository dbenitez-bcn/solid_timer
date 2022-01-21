import 'dart:async';

import 'package:solid_timer/src/bloc/status.dart';

class SolidTimerBloc {
  final StreamController<Status> _statusController = StreamController<Status>();

  SolidTimerBloc() {
    _statusController.add(Status.ready);
  }

  get status => _statusController.stream;

  void play() {
    _statusController.add(Status.playing);
  }

  void stop() {
    _statusController.add(Status.ready);
  }

  void pause() {
    _statusController.add(Status.waiting);
  }
}