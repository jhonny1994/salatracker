import 'package:salat_tracker/features/prayer/prayer.dart';

class NotificationScheduleItem {
  const NotificationScheduleItem({
    required this.id,
    required this.scheduledAt,
    required this.isEndOfDay,
    this.prayerType,
  });

  final int id;
  final DateTime scheduledAt;
  final PrayerType? prayerType;
  final bool isEndOfDay;
}
