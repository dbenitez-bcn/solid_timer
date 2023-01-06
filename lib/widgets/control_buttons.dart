import 'package:flutter/material.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/bloc/status.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SolidTimerBloc solidTimerBloc = SolidTimerBloc.of(context);
    return StreamBuilder<Status>(
      stream: solidTimerBloc.status,
      initialData: solidTimerBloc.currentStatus,
      builder: (context, snapshot) {
        switch (snapshot.data!) {
          case Status.ready:
            return OutlinedButton(
              onPressed: solidTimerBloc.play,
              child: const Icon(Icons.play_arrow),
            );
          case Status.playing:
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: solidTimerBloc.stop,
                  child: const Icon(Icons.stop),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: solidTimerBloc.pause,
                  child: const Icon(Icons.pause),
                ),
              ],
            );
          case Status.waiting:
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: solidTimerBloc.stop,
                  child: const Icon(Icons.stop),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: solidTimerBloc.play,
                  child: const Icon(Icons.play_arrow),
                ),
              ],
            );
        }
      },
    );
  }
}
