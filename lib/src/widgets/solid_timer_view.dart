import 'package:flutter/material.dart';
import 'package:solid_timer/src/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/src/widgets/control_buttons.dart';
import 'package:solid_timer/src/widgets/timer_view.dart';

class SolidTimer extends StatelessWidget {
  const SolidTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SolidTimerBloc(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: TimerView(),
          ),
          ControlButtons()
        ],
      ),
    );
  }
}
