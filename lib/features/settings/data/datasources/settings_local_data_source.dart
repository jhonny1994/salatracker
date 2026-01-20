import 'package:hive_ce/hive.dart';
import 'package:salat_tracker/features/settings/domain/models/settings.dart';

class SettingsLocalDataSource {
  SettingsLocalDataSource(this._box);

  static const _settingsKey = 'settings';

  final Box<Settings> _box;

  Settings fetchSettings() {
    return _box.get(_settingsKey) ?? Settings.defaults();
  }

  Future<void> saveSettings(Settings settings) async {
    await _box.put(_settingsKey, settings);
  }

  Stream<Settings> watchSettings() async* {
    yield fetchSettings();
    yield* _box.watch(key: _settingsKey).map((event) {
      return event.value as Settings? ?? Settings.defaults();
    });
  }
}
