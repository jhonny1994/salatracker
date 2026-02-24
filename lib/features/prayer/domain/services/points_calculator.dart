import 'package:salat_tracker/features/prayer/prayer.dart';

/// Calculates points earned for completing prayers.
///
/// Awards base points per completed prayer plus bonus points for completing
/// all prayers in a day.
class PointsCalculator {
  const PointsCalculator();

  /// Calculates the total points earned for a given prayer day.
  ///
  /// Returns base points (10 per prayer) plus a daily completion bonus.
  int forDay(PrayerDay day) {
    final completed = day.entries.where((entry) => entry.isCompleted).length;
    final basePoints = completed * 10;
    final dailyBonus = completed == day.entries.length && day.entries.isNotEmpty
        ? 50
        : 0;
    return basePoints + dailyBonus;
  }
}
