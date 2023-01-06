import 'package:solid_timer/domain/models/solid_timer.dart';

import '../../bloc/status.dart';

class AppState {
  List<SolidTimer> timersList;
  SolidTimer lastSelectedTimer;
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
