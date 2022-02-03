import 'package:flutter/material.dart';
import 'package:solid_timer/src/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/src/persistance/sqflite_db_helper.dart';
import 'package:solid_timer/src/persistance/sqflite_timer_repository.dart';
import 'package:solid_timer/src/widgets/control_buttons.dart';
import 'package:solid_timer/src/widgets/timer_view.dart';
import 'package:sqflite/sqflite.dart';

class SolidTimer extends StatelessWidget {
  const SolidTimer({Key? key}) : super(key: key);

  Future<void> foo() async {
    // await Future.delayed(const Duration(seconds: 1));
    await dbInitialization();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
      future: dbInitialization(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final repository = SqfliteTimerRepository(snapshot.data!);
            return SolidTimerBloc(
              repository,
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
            )..load();
          default:
            return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
