abstract class ConfigurationRepository {
  Future<bool> getIsSoundEnabled();
  Future<void> setIsSoundEnabled(bool value);
}