import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/domain/dtos/app_initializer_dto.dart';
import 'package:solid_timer/domain/models/app_state.dart';
import 'package:solid_timer/domain/models/timer.dart';
import 'package:solid_timer/persistance/sqflite_configuration_repository.dart';
import 'package:solid_timer/persistance/sqflite_db_helper.dart';
import 'package:solid_timer/persistance/sqflite_timer_repository.dart';
import 'package:solid_timer/widgets/buttons/infinite_button.dart';
import 'package:solid_timer/widgets/control_buttons.dart';
import 'package:solid_timer/widgets/timer_buttons.dart';
import 'package:solid_timer/widgets/timer_view.dart';

import '../bloc/status.dart';
import 'buttons/muted_button.dart';

class SolidTimer extends StatelessWidget {
  const SolidTimer({Key? key}) : super(key: key);

  Future<AppInitializerDto> _appInitialization() async {
    var timersRepository = SqfliteTimerRepository(await dbInitialization());
    var configurationRepository = SharedPreferencesConfigurationRepository(
        await SharedPreferences.getInstance());
    return AppInitializerDto(
      AppState(
        await timersRepository.getAll(),
        await timersRepository.getLastSelectedTimer() ?? Timer(1, 30),
        await configurationRepository.getIsSoundEnabled(),
        await configurationRepository.getIsInfiniteRoundEnabled(),
        Status.ready,
        0,
      ),
      configurationRepository,
      timersRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppInitializerDto>(
      future: _appInitialization(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return SolidTimerBloc(
            snapshot.data!.timerRepository,
            snapshot.data!.configurationRepository,
            snapshot.data!.initialAppState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Row(
                      children: const [
                        InfiniteButton(),
                        MutedButton(),
                      ],
                    ),
                    const TimerButtons(),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: const TimerView(),
                ),
                const ControlButtons()
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }
}
