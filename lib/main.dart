import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solid_timer/bloc/solid_timer_bloc.dart';
import 'package:solid_timer/domain/dtos/app_initializer_dto.dart';
import 'package:solid_timer/domain/models/app_state.dart';
import 'package:solid_timer/domain/models/solid_timer.dart';
import 'package:solid_timer/persistance/sqflite_configuration_repository.dart';
import 'package:solid_timer/persistance/sqflite_db_helper.dart';
import 'package:solid_timer/persistance/sqflite_timer_repository.dart';
import 'package:solid_timer/widgets/solid_timer_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    return FutureBuilder<AppInitializerDto>(
      future: _appInitialization(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return SolidTimerBloc(
              snapshot.data!.timerRepository,
              snapshot.data!.configurationRepository,
              snapshot.data!.initialAppState,
              child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  LocalJsonLocalization.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('es', ''),
                  Locale('ca', ''),
                  Locale('pt', ''),
                  Locale('fr', ''),
                  Locale('it', ''),
                  Locale('de', ''),
                ],
                localeResolutionCallback: _localeResolution,
                home: const SolidTimerHome(),
              ));
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

  Locale? _localeResolution(locale, supportedLocales) {
    Locale userLocale = Locale(locale?.languageCode ?? "en", "");
    if (supportedLocales.contains(userLocale)) {
      return userLocale;
    }
    return const Locale('en', '');
  }
}
