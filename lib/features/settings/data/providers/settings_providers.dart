import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';

part 'settings_providers.g.dart';

/// Provider for the settings local data source.
@riverpod
SettingsLocalDataSource settingsLocalDataSource(Ref ref) {
  final box = Hive.box<Settings>(HiveService.settingsBoxName);
  return SettingsLocalDataSource(box);
}

/// Provider for the settings repository.
@riverpod
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepositoryImpl(ref.read(settingsLocalDataSourceProvider));
}

/// Provider for the app version string from platform metadata.
@riverpod
Future<String> appVersion(Ref ref) async {
  final info = await PackageInfo.fromPlatform();
  if (info.buildNumber.isEmpty) {
    return info.version;
  }
  return '${info.version}+${info.buildNumber}';
}

/// Notifier managing application settings state.
///
/// Provides methods to update theme, language, notifications, and other
/// user preferences with persistence.
@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Future<Settings> build() async {
    final repository = ref.read(settingsRepositoryProvider);
    final settings = await repository.fetchSettings();

    if (settings.notificationsEnabled) {
      await _scheduleForSettings(settings);
    }

    return settings;
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

  Future<void> updatePrayerTime({
    required PrayerType type,
    required TimeOfDay time,
  }) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updatedTimes = Map<PrayerType, TimeOfDay>.from(current.prayerTimes);
      updatedTimes[type] = time;

      final updated = current.copyWith(prayerTimes: updatedTimes);
      await repository.saveSettings(updated);

      if (updated.notificationsEnabled) {
        await _scheduleForSettings(updated);
      }

      return updated;
    });
  }

  Future<void> updatePrayerOffset({
    required PrayerType type,
    required int offsetMinutes,
  }) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updatedOffsets = Map<PrayerType, int>.from(current.offsets);
      updatedOffsets[type] = offsetMinutes;

      final updated = current.copyWith(offsets: updatedOffsets);
      await repository.saveSettings(updated);

      if (updated.notificationsEnabled) {
        await _scheduleForSettings(updated);
      }

      return updated;
    });
  }

  Future<void> updateWeekStart(int weekday) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updated = current.copyWith(weekStart: weekday);
      await repository.saveSettings(updated);
      return updated;
    });
  }

  Future<void> updateAppLockEnabled({required bool enabled}) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updated = current.copyWith(appLockEnabled: enabled);
      await repository.saveSettings(updated);
      return updated;
    });
  }

  Future<void> toggleNotifications({required bool enabled}) async {
    final repository = ref.read(settingsRepositoryProvider);
    final notificationService = ref.read(notificationServiceProvider);

    // 1. Request permissions if enabling
    if (enabled) {
      final granted = await notificationService.requestPermissions();
      if (!granted) {
        // Permission denied, do not enable
        return;
      }
    }

    // 2. Update Settings
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updated = current.copyWith(notificationsEnabled: enabled);
      await repository.saveSettings(updated);
      return updated;
    });

    // 3. Handle Scheduling
    if (nativeState.hasValue &&
        (nativeState.value?.notificationsEnabled ?? false) == enabled) {
      if (enabled) {
        final current = state.asData?.value ?? Settings.defaults();
        await _scheduleForSettings(
          current.copyWith(notificationsEnabled: true),
        );
      } else {
        await notificationService.cancelAll();
      }
    }

    // 4. Analytics
    unawaited(
      ref
          .read(analyticsProvider)
          .logEvent(
            'notifications_toggled',
            parameters: {AnalyticsParam.enabled: enabled},
          ),
    );
  }

  Future<void> _scheduleForSettings(Settings currentSettings) async {
    final notificationService = ref.read(notificationServiceProvider);
    await notificationService.cancelAll();

    final times = currentSettings.prayerTimes;

    final now = DateTime.now();

    for (final type in PrayerType.values) {
      final time = times[type] ?? const TimeOfDay(hour: 0, minute: 0);
      final offset = currentSettings.offsets[type] ?? 0;
      final scheduledTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      ).add(Duration(minutes: offset));

      final s = S.current;
      final prayerName = _prayerName(type, s);

      await notificationService.schedulePrayer(
        id: type.index,
        title: s.notificationTitle(prayerName),
        body: s.notificationBody(prayerName),
        scheduledAt: scheduledTime,
        repeatsDaily: true,
        payload: '/today',
      );
    }

    final ishaTime =
        times[PrayerType.isha] ?? const TimeOfDay(hour: 20, minute: 30);
    final reflectionTime = DateTime(
      now.year,
      now.month,
      now.day,
      ishaTime.hour,
      ishaTime.minute,
    ).add(const Duration(hours: 2));

    await notificationService.schedulePrayer(
      id: 99,
      title: S.current.endOfDayTitle,
      body: S.current.endOfDayBody,
      scheduledAt: reflectionTime,
      repeatsDaily: true,
      payload: '/today',
    );
  }

  String _prayerName(PrayerType type, S s) {
    return switch (type) {
      PrayerType.fajr => s.prayerFajr,
      PrayerType.dhuhr => s.prayerDhuhr,
      PrayerType.asr => s.prayerAsr,
      PrayerType.maghrib => s.prayerMaghrib,
      PrayerType.isha => s.prayerIsha,
    };
  }

  /// Marks onboarding as complete.
  Future<void> markOnboardingComplete() async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updated = current.copyWith(onboardingComplete: true);
      await repository.saveSettings(updated);
      return updated;
    });
  }

  // Helper to access state value safely or just use local logic
  AsyncValue<Settings> get nativeState => state;
}
