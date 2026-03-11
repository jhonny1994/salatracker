import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

@riverpod
NotificationSchedulePlanner notificationSchedulePlanner(Ref ref) {
  return const NotificationSchedulePlanner();
}

final locationContextStoreProvider = Provider<LocationContextStore>((ref) {
  final box = Hive.box<String>(HiveService.locationBoxName);
  return LocationContextStore(box);
});

final locationContextResolverProvider = Provider<LocationContextResolver>(
  (ref) => const LocationContextResolver(),
);

final locationContextNotifierProvider =
    AsyncNotifierProvider<LocationContextNotifier, LocationContext>(
      LocationContextNotifier.new,
    );

class LocationContextNotifier extends AsyncNotifier<LocationContext> {
  @override
  Future<LocationContext> build() async {
    final store = ref.read(locationContextStoreProvider);
    final settings = await ref.read(settingsProvider.future);
    final localeCode = settings.localeCode ?? 'en';
    final mode = store.readMode();
    final manualTimezoneId = store.readManualTimezoneId();
    final cached = store.readCachedContext();

    final context = await ref
        .read(locationContextResolverProvider)
        .resolve(
          localeCode: localeCode,
          mode: mode,
          manualTimezoneId: manualTimezoneId,
          cached: cached,
        );
    await store.writeCachedContext(context);
    return context;
  }

  Future<void> refresh({bool allowPermissionPrompt = true}) async {
    final store = ref.read(locationContextStoreProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final settings = await ref.read(settingsProvider.future);
      final localeCode = settings.localeCode ?? 'en';
      final mode = store.readMode();
      final manualTimezoneId = store.readManualTimezoneId();
      final cached = store.readCachedContext();
      final context = await ref
          .read(locationContextResolverProvider)
          .resolve(
            localeCode: localeCode,
            mode: mode,
            manualTimezoneId: manualTimezoneId,
            cached: cached,
            allowPermissionPrompt: allowPermissionPrompt,
          );
      await store.writeCachedContext(context);
      return context;
    });
  }

  Future<void> setMode(LocationMode mode) async {
    final store = ref.read(locationContextStoreProvider);
    await store.writeMode(mode);
    await refresh();
  }

  Future<void> setManualTimezoneId(String timezoneId) async {
    final store = ref.read(locationContextStoreProvider);
    await store.writeMode(LocationMode.manual);
    await store.writeManualTimezoneId(timezoneId);
    await refresh();
  }
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
@Riverpod(keepAlive: true)
class SettingsNotifier extends _$SettingsNotifier {
  bool _didBootstrapNotifications = false;
  bool _isSchedulingNotifications = false;
  bool _schedulePending = false;
  Settings? _latestSchedulingRequest;

  @override
  Future<Settings> build() async {
    final repository = ref.read(settingsRepositoryProvider);
    final settings = await repository.fetchSettings();

    if (settings.notificationsEnabled && !_didBootstrapNotifications) {
      _didBootstrapNotifications = true;
      unawaited(_scheduleForSettings(settings));
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

      if (updated.notificationsEnabled) {
        await _scheduleForSettings(updated);
      }

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

  Future<void> addDailyReminder({required TimeOfDay time}) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updatedReminders = [
        ...current.effectiveDailyReminders,
        DailyReminderConfig(
          id: current.nextDailyReminderId,
          time: time,
          enabled: true,
        ),
      ];

      final updated = current.copyWith(dailyReminders: updatedReminders);
      await repository.saveSettings(updated);

      if (updated.notificationsEnabled) {
        await _scheduleForSettings(updated);
      }

      return updated;
    });
  }

  Future<void> updateDailyReminderTime({
    required int reminderId,
    required TimeOfDay time,
  }) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updatedReminders = Settings.normalizeDailyReminders(
        current.effectiveDailyReminders
            .map((reminder) {
              if (reminder.id != reminderId) {
                return reminder;
              }
              return reminder.copyWith(time: time);
            })
            .toList(growable: false),
      );

      final updated = current.copyWith(dailyReminders: updatedReminders);
      await repository.saveSettings(updated);

      if (updated.notificationsEnabled) {
        await _scheduleForSettings(updated);
      }

      return updated;
    });
  }

  Future<void> toggleDailyReminder({
    required int reminderId,
    required bool enabled,
  }) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updatedReminders = current.effectiveDailyReminders
          .map((reminder) {
            if (reminder.id != reminderId) {
              return reminder;
            }
            return reminder.copyWith(enabled: enabled);
          })
          .toList(growable: false);

      final updated = current.copyWith(dailyReminders: updatedReminders);
      await repository.saveSettings(updated);

      if (updated.notificationsEnabled) {
        await _scheduleForSettings(updated);
      }

      return updated;
    });
  }

  Future<void> removeDailyReminder({required int reminderId}) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updatedReminders = current.effectiveDailyReminders
          .where((reminder) => reminder.id != reminderId)
          .toList(growable: false);

      final updated = current.copyWith(dailyReminders: updatedReminders);
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

  Future<void> updateBiometricUnlockEnabled({required bool enabled}) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final updated = current.copyWith(biometricUnlockEnabled: enabled);
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

  Future<void> applyOnboardingConfiguration({
    required Map<PrayerType, TimeOfDay> prayerTimes,
    required TimeOfDay lateReminderTime,
  }) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final current = await future;
      final firstReminderId = current.effectiveDailyReminders.isEmpty
          ? DailyReminderConfig.defaultReminderId
          : current.effectiveDailyReminders.first.id;
      final updated = current.copyWith(
        prayerTimes: Map<PrayerType, TimeOfDay>.from(prayerTimes),
        dailyReminders: Settings.normalizeDailyReminders([
          DailyReminderConfig(
            id: firstReminderId,
            time: lateReminderTime,
            enabled: true,
          ),
        ]),
      );
      await repository.saveSettings(updated);

      if (updated.notificationsEnabled) {
        await _scheduleForSettings(updated);
      }

      return updated;
    });
  }

  Future<void> _scheduleForSettings(Settings currentSettings) async {
    _latestSchedulingRequest = currentSettings;
    if (_isSchedulingNotifications) {
      _schedulePending = true;
      return;
    }
    _isSchedulingNotifications = true;

    try {
      while (true) {
        final settingsToSchedule = _latestSchedulingRequest ?? currentSettings;
        _schedulePending = false;

        final notificationService = ref.read(notificationServiceProvider);
        final planner = ref.read(notificationSchedulePlannerProvider);
        LocationContext? locationContext;
        try {
          locationContext = await ref.read(
            locationContextNotifierProvider.future,
          );
        } on Object {
          locationContext = null;
        }

        await notificationService.cancelAll();
        await notificationService.refreshTimezone(
          preferredTimezoneId: locationContext?.timezoneId,
        );
        final now = DateTime.now();
        final schedule = planner.buildDailySchedule(
          settings: settingsToSchedule,
          now: now,
        );

        for (final item in schedule) {
          final s = S.current;
          switch (item.kind) {
            case NotificationScheduleKind.dailyReminder:
              final intent = NotificationIntent.dailyCheckin(
                intentId:
                    'daily_${item.id}_${item.scheduledAt.toIso8601String()}',
                scheduledAt: item.scheduledAt,
                sourceNotificationId: item.id,
              );
              await notificationService.schedulePrayer(
                id: item.id,
                title: s.dailyReminderTitle,
                body: s.dailyReminderBody,
                scheduledAt: item.scheduledAt,
                repeatsDaily: true,
                payload: intent.toPayload(),
              );
            case NotificationScheduleKind.prayer:
              final prayerName = _prayerName(item.prayerType!, s);
              final prayerId = item.prayerType!.name;
              final scheduledAtIso = item.scheduledAt.toIso8601String();
              final intent = NotificationIntent.prayer(
                intentId: 'prayer_${prayerId}_${item.id}_$scheduledAtIso',
                prayerType: item.prayerType!,
                date: item.scheduledAt,
                scheduledAt: item.scheduledAt,
                sourceNotificationId: item.id,
              );
              await notificationService.schedulePrayer(
                id: item.id,
                title: s.notificationTitle(prayerName),
                body: s.notificationBody(prayerName),
                scheduledAt: item.scheduledAt,
                repeatsDaily: true,
                payload: intent.toPayload(),
              );
          }
        }

        if (!_schedulePending) {
          break;
        }
      }
    } finally {
      _isSchedulingNotifications = false;
      _latestSchedulingRequest = null;
    }
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
