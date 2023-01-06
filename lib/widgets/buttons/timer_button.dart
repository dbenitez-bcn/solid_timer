import 'package:flutter/material.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/domain/models/timer.dart';

import 'base_solid_timer_button.dart';

class TimerButton extends BaseSolidTimerButton {
  final Timer timer;

  TimerButton.enabled(
      {Key? key, required this.timer, required BuildContext context})
      : super(
          key: key,
          onPressed: () {
            SolidTimerBloc.of(context).select(timer);
          },
          child: Text(timer.toClockFormat()),
        );

  TimerButton.disabled(
      {Key? key, required this.timer, required BuildContext context})
      : super(
          key: key,
          onPressed: null,
          child: Text(timer.toClockFormat()),
        );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        super.build(context),
        GestureDetector(
          onTap: () {
            SolidTimerBloc.of(context).remove(timer.id);
          },
          child: Container(
            decoration:
                const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
