import 'package:flutter/material.dart';
import 'package:solid_timer/src/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/src/domain/models/timer.dart';
import 'package:solid_timer/src/utils/solid_timer_utils.dart';

import 'base_solid_timer_button.dart';

class TimerButton extends BaseSolidTimerButton {

  TimerButton({Key? key, required Timer timer, required BuildContext context})
      : super(
          key: key,
          onPressed: null,
          onLongPress: () {
            SolidTimerBloc.of(context).remove(timer.id);
          },
          child: Text(formatTime(timer.seconds)),
        );
}
