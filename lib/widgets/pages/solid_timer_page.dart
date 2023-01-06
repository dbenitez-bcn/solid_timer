import 'package:flutter/material.dart';
import 'package:solid_timer/widgets/buttons/muted_button.dart';
import 'package:solid_timer/widgets/control_buttons.dart';
import 'package:solid_timer/widgets/timer_view.dart';

class SolidTimerPage extends StatelessWidget {
  const SolidTimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Spacer(),
            MutedButton(),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: const TimerView(),
        ),
        const ControlButtons()
      ],
    );
  }
}
