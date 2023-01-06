import 'package:solid_timer/domain/datasource/configuration_repository.dart';
import 'package:solid_timer/domain/datasource/timer_repository.dart';
import 'package:solid_timer/domain/models/app_state.dart';

class AppInitializerDto {
  final AppState initialAppState;
  final ConfigurationRepository configurationRepository;
  final TimerRepository timerRepository;

  AppInitializerDto(
    this.initialAppState,
    this.configurationRepository,
    this.timerRepository,
  );
}
