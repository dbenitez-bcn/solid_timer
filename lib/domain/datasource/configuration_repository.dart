abstract class ConfigurationRepository {
  Future<bool> getIsSoundEnabled();
  Future<bool> getIsInfiniteRoundEnabled();
  Future<void> setIsSoundEnabled(bool value);
  Future<void> setIsInfiniteRoundEnabled(bool value);
}