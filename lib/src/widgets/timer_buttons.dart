import 'package:flutter/material.dart';
import 'package:solid_timer/src/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/src/domain/models/timer.dart';

class TimerButtons extends StatelessWidget {
  const TimerButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var solidTimerBloc = SolidTimerBloc.of(context);
    return StreamBuilder<List<Timer>>(
        stream: solidTimerBloc.timers,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
            snapshot.data!.map((e) => OutlinedButton(
              onPressed: null,
              onLongPress: () {
                solidTimerBloc.remove(e.id);
              },
              child: Text("${e.seconds}"),
            )).toList()
            +
            [
              OutlinedButton(
                onPressed: () {
                  solidTimerBloc.addTimer(10);
                },
                child: const Icon(Icons.add),
              ),

            ],
          );
        });
  }
}
