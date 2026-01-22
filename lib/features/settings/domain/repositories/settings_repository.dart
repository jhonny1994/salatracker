import 'package:salat_tracker/features/settings/settings.dart';

/// Repository interface for settings persistence.
abstract class SettingsRepository {
  Future<Settings> fetchSettings();
  Future<void> saveSettings(Settings settings);
  Stream<Settings> watchSettings();
}
