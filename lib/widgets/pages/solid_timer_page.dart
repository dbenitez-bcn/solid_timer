import 'package:flutter/material.dart';
import 'package:solid_timer/widgets/buttons/muted_button.dart';
import 'package:solid_timer/widgets/control_buttons.dart';
import 'package:solid_timer/widgets/timer_view.dart';

class SolidTimerPage extends StatefulWidget {
  const SolidTimerPage({Key? key}) : super(key: key);

  @override
  State<SolidTimerPage> createState() => _SolidTimerPageState();
}

class _SolidTimerPageState extends State<SolidTimerPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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

  @override
  bool get wantKeepAlive => true;
}
