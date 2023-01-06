import 'package:flutter/material.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/bloc/status.dart';
import 'package:solid_timer/domain/models/solid_timer.dart';
import 'package:solid_timer/widgets/buttons/timer_button.dart';

import 'buttons/add_timer_button.dart';

class TimerButtons extends StatelessWidget {
  const TimerButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var solidTimerBloc = SolidTimerBloc.of(context);
    return StreamBuilder<Status>(
        stream: solidTimerBloc.status,
        initialData: solidTimerBloc.currentStatus,
        builder: (context, snapshot) {
          Status status = snapshot.data ?? Status.ready;
          return StreamBuilder<List<SolidTimer>>(
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
                  children: _buildButtons(snapshot.data!, context, status));
            },
          );
        });
  }

  List<Widget> _buildButtons(
      List<SolidTimer> list, BuildContext context, Status status) {
    List<Widget> buttons =
        list.map((timer) => _buildTimerButton(timer, context, status)).toList();
    if (buttons.length < 3) buttons.add(_buildAddButton(context, status));
    if (buttons.length < 3) {
      buttons += _buildDisabledButtons(buttons.length, context);
    }
    return buttons;
  }

  Widget _buildTimerButton(SolidTimer timer, BuildContext context, Status status) {
    return status == Status.ready
        ? TimerButton.enabled(
            timer: timer,
            context: context,
          )
        : TimerButton.disabled(
            timer: timer,
            context: context,
          );
  }

  Widget _buildAddButton(BuildContext context, Status status) {
    return status == Status.ready
        ? AddTimerButton.enabled(context: context)
        : const AddTimerButton.disabled();
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
