import 'package:salat_tracker/features/prayer/prayer.dart';

class PointsCalculator {
  const PointsCalculator();

  int forDay(PrayerDay day) {
    final completed = day.entries.where((entry) => entry.isCompleted).length;
    final basePoints = completed * 10;
    final dailyBonus = completed == day.entries.length && day.entries.isNotEmpty
        ? 5
        : 0;
    return basePoints + dailyBonus;
  }
}
