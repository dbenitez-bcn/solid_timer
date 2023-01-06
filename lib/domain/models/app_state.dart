import 'package:solid_timer/domain/models/timer.dart';

import '../../bloc/status.dart';

class AppState {
  List<Timer> timersList;
  Timer lastSelectedTimer;
  bool isSoundEnabled;
  Status status;
  int pageIndex;

  AppState(
    this.timersList,
    this.lastSelectedTimer,
    this.isSoundEnabled,
    this.status,
    this.pageIndex
  );
}
