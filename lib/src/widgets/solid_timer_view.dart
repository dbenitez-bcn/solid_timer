import 'package:flutter/material.dart';
import 'package:solid_timer/src/widgets/timer_view.dart';

class SolidTimer extends StatelessWidget {
  const SolidTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TimerView(),
    );
  }
}
