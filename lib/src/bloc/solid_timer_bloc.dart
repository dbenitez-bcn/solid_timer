import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:solid_timer/src/bloc/status.dart';

class SolidTimerBloc extends InheritedWidget {
  final StreamController<Status> _statusController = StreamController<Status>();

  SolidTimerBloc({Key? key, required child}) : super(key: key, child: child) {
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

  static SolidTimerBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SolidTimerBloc>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}