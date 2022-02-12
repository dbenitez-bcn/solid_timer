import 'package:flutter/material.dart';
import 'package:solid_timer/src/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/src/domain/models/timer.dart';
import 'package:solid_timer/src/widgets/timer_progress_indicator.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: StreamBuilder<Timer>(
        stream: SolidTimerBloc.of(context).selectedTimer,
        builder: (context, snapshot) {
          return AnimatedOpacity(
            opacity: snapshot.hasData ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: snapshot.hasData
                ? TimerProgressIndicator(
                    timer: snapshot.data!,
                  )
                : null,
          );
        },
      ),
    );
  }
}
