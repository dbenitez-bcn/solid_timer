import 'package:flutter/material.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/widgets/buttons/base_solid_timer_button.dart';
import 'package:solid_timer/widgets/new_timer_screen.dart';

class AddTimerButton extends BaseSolidTimerButton {
  AddTimerButton.enabled({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          onPressed: () {
            var bloc = SolidTimerBloc.of(context);
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (BuildContext context) => NewTimerScreen(bloc: bloc),
            ));
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
