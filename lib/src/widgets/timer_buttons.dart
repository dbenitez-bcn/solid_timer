import 'package:flutter/material.dart';
import 'package:solid_timer/src/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/src/domain/models/timer.dart';
import 'package:solid_timer/src/widgets/buttons/timer_button.dart';

import 'buttons/add_timer_button.dart';

class TimerButtons extends StatelessWidget {
  const TimerButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var solidTimerBloc = SolidTimerBloc.of(context);
    return StreamBuilder<List<Timer>>(
      stream: solidTimerBloc.timers,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Opacity(
            opacity: 0,
            child: AddTimerButton.disabled(),
          );
        }
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildButtons(snapshot.data!, context));
      },
    );
  }

  List<Widget> _buildButtons(List<Timer> list, BuildContext context) {
    List<Widget> buttons =
        list.map((timer) => _buildTimerButton(timer, context)).toList();
    if (buttons.length < 3) buttons.add(_buildAddButton(context));
    if (buttons.length < 3) {
      buttons += _buildDisabledButtons(buttons.length, context);
    }
    return buttons;
  }

  Widget _buildTimerButton(Timer timer, BuildContext context) {
    return TimerButton(
      timer: timer,
      context: context,
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return AddTimerButton.enabled(context: context);
  }

  List<Widget> _buildDisabledButtons(
    int numberOfButtons,
    BuildContext context,
  ) {
    var emptyButton = const AddTimerButton.disabled();
    if (numberOfButtons == 1) return [emptyButton, emptyButton];
    return [emptyButton];
  }
}
