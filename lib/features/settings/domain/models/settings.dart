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
    @HiveField(4) required bool pointsVisible,
    @HiveField(5) required AppThemeMode themeMode,
    @HiveField(6) required String? localeCode,
    @HiveField(7) required int weekStart,
    @HiveField(8) required bool onboardingComplete,
  }) = _Settings;

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
      pointsVisible: true,
      themeMode: AppThemeMode.system,
      localeCode: null,
      weekStart: DateTime.sunday,
      onboardingComplete: false,
    );
  }
}
