import 'package:salat_tracker/features/prayer/prayer.dart';

enum NotificationScheduleKind { prayer, dailyReminder }

class NotificationScheduleItem {
  const NotificationScheduleItem.prayer({
    required this.id,
    required this.scheduledAt,
    required this.prayerType,
  }) : kind = NotificationScheduleKind.prayer,
       dailyReminderId = null;

  const NotificationScheduleItem.dailyReminder({
    required this.id,
    required this.scheduledAt,
    required this.dailyReminderId,
  }) : kind = NotificationScheduleKind.dailyReminder,
       prayerType = null;

  final int id;
  final DateTime scheduledAt;
  final NotificationScheduleKind kind;
  final PrayerType? prayerType;
  final int? dailyReminderId;

  bool get isPrayer => kind == NotificationScheduleKind.prayer;

  bool get isDailyReminder => kind == NotificationScheduleKind.dailyReminder;
}
