import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/features/settings/data/providers/settings_providers.dart';
import 'package:salat_tracker/features/settings/domain/models/app_theme_mode.dart';
import 'package:salat_tracker/features/settings/domain/models/settings.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  @override
  Future<Settings> build() async {
    final repository = ref.read(settingsRepositoryProvider);
    return repository.fetchSettings();
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    final repository = ref.read(settingsRepositoryProvider);
    final current = state.value ?? Settings.defaults();
    final updated = current.copyWith(themeMode: mode.toAppThemeMode());
    state = AsyncValue.data(updated);
    await repository.saveSettings(updated);
  }

  Future<void> updateLocale(String? localeCode) async {
    final repository = ref.read(settingsRepositoryProvider);
    final current = state.value ?? Settings.defaults();
    final updated = current.copyWith(localeCode: localeCode);
    state = AsyncValue.data(updated);
    await repository.saveSettings(updated);
  }
}
