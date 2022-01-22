import 'package:flutter/material.dart';
import 'package:solid_timer/src/widgets/timer_progress_indicator.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:EdgeInsets.symmetric(horizontal: 12.0),
      child: TimerProgressIndicator(
        duration: 1,
      ),
    );
  }
}
