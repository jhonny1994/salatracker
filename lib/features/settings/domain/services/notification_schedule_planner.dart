import 'package:flutter/material.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/domain/models/settings.dart';
import 'package:salat_tracker/features/settings/domain/services/notification_schedule_item.dart';

class NotificationSchedulePlanner {
  const NotificationSchedulePlanner();

  List<NotificationScheduleItem> buildDailySchedule({
    required Settings settings,
    required DateTime now,
  }) {
    final items = <NotificationScheduleItem>[];

    for (final type in PrayerType.values) {
      final time =
          settings.prayerTimes[type] ?? const TimeOfDay(hour: 0, minute: 0);
      final offset = settings.offsets[type] ?? 0;
      final rawTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      ).add(Duration(minutes: offset));

      final scheduledAt = rawTime.isAfter(now)
          ? rawTime
          : rawTime.add(const Duration(days: 1));

      items.add(
        NotificationScheduleItem(
          id: type.index,
          prayerType: type,
          scheduledAt: scheduledAt,
          isEndOfDay: false,
        ),
      );
    }

    final ishaTime =
        settings.prayerTimes[PrayerType.isha] ??
        const TimeOfDay(hour: 20, minute: 30);
    final reflectionRaw = DateTime(
      now.year,
      now.month,
      now.day,
      ishaTime.hour,
      ishaTime.minute,
    ).add(const Duration(hours: 2));

    final reflectionScheduled = reflectionRaw.isAfter(now)
        ? reflectionRaw
        : reflectionRaw.add(const Duration(days: 1));

    items.add(
      NotificationScheduleItem(
        id: 99,
        scheduledAt: reflectionScheduled,
        isEndOfDay: true,
      ),
    );

    return items;
  }
}
