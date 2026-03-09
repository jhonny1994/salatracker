import 'package:flutter/material.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';

class NotificationSchedulePlanner {
  const NotificationSchedulePlanner();

  static const dailyReminderNotificationIdBase = 1000;

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
        NotificationScheduleItem.prayer(
          id: type.index,
          prayerType: type,
          scheduledAt: scheduledAt,
        ),
      );
    }

    for (final reminder in settings.effectiveDailyReminders) {
      if (!reminder.enabled) {
        continue;
      }

      final rawTime = DateTime(
        now.year,
        now.month,
        now.day,
        reminder.time.hour,
        reminder.time.minute,
      );

      final scheduledAt = rawTime.isAfter(now)
          ? rawTime
          : rawTime.add(const Duration(days: 1));

      items.add(
        NotificationScheduleItem.dailyReminder(
          id: dailyReminderNotificationIdBase + reminder.id,
          dailyReminderId: reminder.id,
          scheduledAt: scheduledAt,
        ),
      );
    }

    return items;
  }
}
