import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/domain/dtos/app_initializer_dto.dart';
import 'package:solid_timer/domain/models/app_state.dart';
import 'package:solid_timer/domain/models/solid_timer.dart';
import 'package:solid_timer/persistance/sqflite_configuration_repository.dart';
import 'package:solid_timer/persistance/sqflite_db_helper.dart';
import 'package:solid_timer/persistance/sqflite_timer_repository.dart';
import 'package:solid_timer/widgets/buttons/solid_floating_button.dart';
import 'package:solid_timer/widgets/solid_page_view.dart';

import 'solid_navigation_bar.dart';

class SolidTimerHome extends StatelessWidget {
  const SolidTimerHome({Key? key}) : super(key: key);

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
            child: const Scaffold(
              body: SolidPageView(),
              bottomNavigationBar: SolidNavigationBar(),
              floatingActionButton: SolidFloatingButton(),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }

  Future<AppInitializerDto> _appInitialization() async {
    var timersRepository = SqfliteTimerRepository(await dbInitialization());
    var configurationRepository = SharedPreferencesConfigurationRepository(
        await SharedPreferences.getInstance());
    return AppInitializerDto(
      AppState(
        await timersRepository.getAll(),
        await timersRepository.getLastSelectedTimer() ??
            SolidTimer(1, 30, null, null),
        await configurationRepository.getIsSoundEnabled(),
      ),
      configurationRepository,
      timersRepository,
    );
  }
}
