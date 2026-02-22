import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';

void main() {
  group('NotificationSchedulePlanner', () {
    const planner = NotificationSchedulePlanner();

    test('returns five prayer reminders and one end-of-day reminder', () {
      final now = DateTime(2026, 2, 10, 8);
      final schedule = planner.buildDailySchedule(
        settings: Settings.defaults(),
        now: now,
      );

      expect(schedule.length, 6);
      expect(
        schedule.where((item) => !item.isEndOfDay).map((item) => item.id),
        orderedEquals([0, 1, 2, 3, 4]),
      );
      expect(schedule.where((item) => item.isEndOfDay).single.id, 99);
      expect(schedule.map((item) => item.id).toSet().length, schedule.length);
    });

    test('marks end-of-day item without prayer type', () {
      final schedule = planner.buildDailySchedule(
        settings: Settings.defaults(),
        now: DateTime(2026, 2, 10, 8),
      );

      final endOfDay = schedule.singleWhere((item) => item.isEndOfDay);
      expect(endOfDay.prayerType, isNull);
    });

    test('rolls passed prayer times to next day', () {
      final settings = Settings.defaults().copyWith(
        prayerTimes: {
          PrayerType.fajr: const TimeOfDay(hour: 5, minute: 0),
          PrayerType.dhuhr: const TimeOfDay(hour: 13, minute: 0),
          PrayerType.asr: const TimeOfDay(hour: 16, minute: 30),
          PrayerType.maghrib: const TimeOfDay(hour: 19, minute: 0),
          PrayerType.isha: const TimeOfDay(hour: 20, minute: 30),
        },
      );

      final now = DateTime(2026, 2, 10, 22);
      final schedule = planner.buildDailySchedule(settings: settings, now: now);

      for (final item in schedule) {
        expect(item.scheduledAt.isAfter(now), isTrue);
      }
    });

    test('applies reminder offsets when building prayer schedule', () {
      final settings = Settings.defaults().copyWith(
        prayerTimes: {
          PrayerType.fajr: const TimeOfDay(hour: 5, minute: 0),
          PrayerType.dhuhr: const TimeOfDay(hour: 13, minute: 0),
          PrayerType.asr: const TimeOfDay(hour: 16, minute: 30),
          PrayerType.maghrib: const TimeOfDay(hour: 19, minute: 0),
          PrayerType.isha: const TimeOfDay(hour: 20, minute: 30),
        },
        offsets: {
          PrayerType.fajr: 10,
          PrayerType.dhuhr: -5,
          PrayerType.asr: 0,
          PrayerType.maghrib: 0,
          PrayerType.isha: 0,
        },
      );

      final now = DateTime(2026, 2, 10, 4);
      final schedule = planner.buildDailySchedule(settings: settings, now: now);

      final fajr = schedule.firstWhere(
        (item) => item.prayerType == PrayerType.fajr,
      );
      final dhuhr = schedule.firstWhere(
        (item) => item.prayerType == PrayerType.dhuhr,
      );

      expect(fajr.scheduledAt.hour, 5);
      expect(fajr.scheduledAt.minute, 10);

      expect(dhuhr.scheduledAt.hour, 12);
      expect(dhuhr.scheduledAt.minute, 55);
    });
  });
}
