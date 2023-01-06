import 'package:flutter/material.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/bloc/status.dart';
import 'package:solid_timer/widgets/timer_progress_indicator.dart';
import 'package:solid_timer/widgets/timer_ready_indicator.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: StreamBuilder<Status>(
        initialData: Status.ready,
        stream: SolidTimerBloc.of(context).status,
        builder: (context, snapshot) {
          switch (snapshot.data!) {
            case Status.ready:
              return const TimerReadyIndicator();
            default:
              return TimerProgressIndicator(
                timer: SolidTimerBloc.of(context).currentTimer!,
              );
          }
        },
      ),
    );
  }
}
