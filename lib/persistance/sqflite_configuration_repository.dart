import 'package:shared_preferences/shared_preferences.dart';
import 'package:solid_timer/domain/datasource/configuration_repository.dart';

class SharedPreferencesConfigurationRepository extends ConfigurationRepository {
  final SharedPreferences preferences;

  SharedPreferencesConfigurationRepository(this.preferences);

  @override
  Future<bool> getIsSoundEnabled() async {
    return preferences.getBool("sound_enabled") ?? false;
  }

  @override
  Future<void> setIsSoundEnabled(bool value) async {
    await preferences.setBool("sound_enabled", value);
  }

}