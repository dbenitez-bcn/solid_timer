import 'package:flutter/material.dart';
import 'package:solid_timer/src/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/src/widgets/buttons/base_solid_timer_button.dart';

class AddTimerButton extends BaseSolidTimerButton {
  AddTimerButton.enabled({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          onPressed: () {
            SolidTimerBloc.of(context).addTimer(10);
          },
          child: const Icon(Icons.add),
        );

  const AddTimerButton.disabled({Key? key})
      : super(
          key: key,
          onPressed: null,
          child: const Icon(Icons.add),
        );
}
