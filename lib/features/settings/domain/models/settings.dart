import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

/// User settings and configuration.
///
/// Persisted locally and used to control application behavior, including
/// prayer times, notifications, and visual appearance.
@freezed
@HiveType(typeId: 4)
abstract class Settings with _$Settings {
  const factory Settings({
    @HiveField(0) required Map<PrayerType, TimeOfDay> prayerTimes,
    @HiveField(1) required Map<PrayerType, int> offsets,
    @HiveField(2) required bool notificationsEnabled,
    @HiveField(3) required bool hapticsEnabled,
    @HiveField(5) required AppThemeMode themeMode,
    @HiveField(6) required String? localeCode,
    @HiveField(7) required int weekStart,
    @HiveField(8) required bool onboardingComplete,
    @HiveField(9) required bool appLockEnabled,
    @HiveField(10) required bool biometricUnlockEnabled,
    @HiveField(11) List<DailyReminderConfig>? dailyReminders,
  }) = _Settings;
  const Settings._();

  factory Settings.defaults() {
    // Standard defaults (can be overridden by user)
    return const Settings(
      prayerTimes: {
        PrayerType.fajr: TimeOfDay(hour: 5, minute: 0),
        PrayerType.dhuhr: TimeOfDay(hour: 13, minute: 0),
        PrayerType.asr: TimeOfDay(hour: 16, minute: 30),
        PrayerType.maghrib: TimeOfDay(hour: 19, minute: 0),
        PrayerType.isha: TimeOfDay(hour: 20, minute: 30),
      },
      offsets: {
        PrayerType.fajr: 0,
        PrayerType.dhuhr: 0,
        PrayerType.asr: 0,
        PrayerType.maghrib: 0,
        PrayerType.isha: 0,
      },
      notificationsEnabled: false,
      hapticsEnabled: true,
      themeMode: AppThemeMode.system,
      localeCode: null,
      weekStart: DateTime.sunday,
      onboardingComplete: false,
      appLockEnabled: false,
      biometricUnlockEnabled: true,
      dailyReminders: [DailyReminderConfig.defaultReminder],
    );
  }

  List<DailyReminderConfig> get effectiveDailyReminders {
    final reminders =
        dailyReminders ?? const [DailyReminderConfig.defaultReminder];
    return normalizeDailyReminders(reminders);
  }

  int get nextDailyReminderId {
    final reminders = effectiveDailyReminders;
    if (reminders.isEmpty) {
      return DailyReminderConfig.defaultReminderId;
    }

    var maxId = reminders.first.id;
    for (final reminder in reminders.skip(1)) {
      if (reminder.id > maxId) {
        maxId = reminder.id;
      }
    }
    return maxId + 1;
  }

  static List<DailyReminderConfig> normalizeDailyReminders(
    Iterable<DailyReminderConfig> reminders,
  ) {
    final seenTimes = <int>{};
    final unique = <DailyReminderConfig>[];

    for (final reminder in reminders) {
      if (seenTimes.add(reminder.totalMinutes)) {
        unique.add(reminder);
      }
    }

    unique.sort((a, b) {
      final timeCompare = a.totalMinutes.compareTo(b.totalMinutes);
      if (timeCompare != 0) {
        return timeCompare;
      }
      return a.id.compareTo(b.id);
    });

    return UnmodifiableListView(unique);
  }
}
