import 'package:flutter/material.dart';
import 'package:solid_timer/src/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/src/widgets/control_buttons.dart';
import 'package:solid_timer/src/widgets/timer_view.dart';

class SolidTimer extends StatelessWidget {
  const SolidTimer({Key? key}) : super(key: key);

  Future<void> foo() async {
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: foo(),
      builder: (context, snapshot) {
        print("SNAPSHOT STATE=> ${snapshot.connectionState}");
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return SolidTimerBloc(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: const TimerView(),
                  ),
                  const ControlButtons()
                ],
              ),
            );
          default:
            return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
