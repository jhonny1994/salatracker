import 'package:salat_tracker/features/settings/domain/models/settings.dart';

abstract class SettingsRepository {
  Future<Settings> fetchSettings();
  Future<void> saveSettings(Settings settings);
  Stream<Settings> watchSettings();
}
