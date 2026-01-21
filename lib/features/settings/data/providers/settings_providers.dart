import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/settings/settings.dart';

part 'settings_providers.g.dart';

@riverpod
SettingsLocalDataSource settingsLocalDataSource(Ref ref) {
  final box = Hive.box<Settings>(HiveService.settingsBoxName);
  return SettingsLocalDataSource(box);
}

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepositoryImpl(ref.read(settingsLocalDataSourceProvider));
}

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Future<Settings> build() async {
    final repository = ref.read(settingsRepositoryProvider);
    return repository.fetchSettings();
  }

  Future<void> updateThemeMode(AppThemeMode mode) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updated = current.copyWith(themeMode: mode);
      await repository.saveSettings(updated);
      return updated;
    });
  }

  Future<void> updateLanguageCode(String code) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updated = current.copyWith(localeCode: code);
      await repository.saveSettings(updated);
      return updated;
    });
  }

  Future<void> updateHaptics({required bool enabled}) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updated = current.copyWith(hapticsEnabled: enabled);
      await repository.saveSettings(updated);
      return updated;
    });
  }

  Future<void> updateShowPoints({required bool show}) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updated = current.copyWith(pointsVisible: show);
      await repository.saveSettings(updated);
      return updated;
    });
  }
}
