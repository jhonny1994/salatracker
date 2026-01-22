import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
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

/// Notifier managing application settings state.
///
/// Provides methods to update theme, language, notifications, and other
/// user preferences with persistence.
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
        await _scheduleUpcomingPrayers();
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
        await _scheduleUpcomingPrayers();
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
        await _scheduleUpcomingPrayers();
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

  Future<void> _scheduleUpcomingPrayers() async {
    final notificationService = ref.read(notificationServiceProvider);

    // Ensure we have the latest settings logic
    final currentSettings = state.asData?.value ?? Settings.defaults();
    final times = currentSettings.prayerTimes;

    final now = DateTime.now();
    // Schedule for today and tomorrow
    for (var i = 0; i < 2; i++) {
      final date = now.add(Duration(days: i));

      for (final type in PrayerType.values) {
        final time = times[type] ?? const TimeOfDay(hour: 0, minute: 0);
        final offset = currentSettings.offsets[type] ?? 0;

        final scheduledTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        ).add(Duration(minutes: offset));

        // Handle if time is in the past for today.
        // But zonedSchedule needs a future time for the *first* trigger.
        // If scheduledTime is passed, we check if we should add a day?
        // No, we are iterating days.
        // If i=1, it is future.
        // But we want to ensure we schedule the NEXT valid instance.

        if (scheduledTime.isBefore(now)) {
          continue;
        }

        final s = S.current;
        final prayerName = type.name;

        await notificationService.schedulePrayer(
          id: i * 10 + type.index, // Unique ID per day per prayer
          title: s.notificationTitle(prayerName),
          body: s.notificationBody(prayerName),
          scheduledAt: scheduledTime,
          payload: '/today',
        );
      }

      // End of Day Reminder (Isha + 2h)
      final ishaTime =
          times[PrayerType.isha] ?? const TimeOfDay(hour: 20, minute: 30);
      final ishaDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        ishaTime.hour,
        ishaTime.minute,
      );
      final reflectionTime = ishaDateTime.add(const Duration(hours: 2));

      if (reflectionTime.isAfter(now)) {
        await notificationService.schedulePrayer(
          id: i * 10 + 9, // ID 9 or 19
          title: S.current.endOfDayTitle,
          body: S.current.endOfDayBody,
          scheduledAt: reflectionTime,
          payload: '/today',
        );
      }
    }
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
