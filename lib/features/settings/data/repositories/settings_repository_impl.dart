import 'package:salat_tracker/features/settings/settings.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._localDataSource);

  final SettingsLocalDataSource _localDataSource;

  @override
  Future<Settings> fetchSettings() async {
    return _localDataSource.fetchSettings();
  }

  @override
  Future<void> saveSettings(Settings settings) {
    return _localDataSource.saveSettings(settings);
  }

  @override
  Stream<Settings> watchSettings() {
    return _localDataSource.watchSettings();
  }
}
