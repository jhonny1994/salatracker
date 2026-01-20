import 'package:salat_tracker/features/prayer/domain/models/prayer_day.dart';
import 'package:salat_tracker/shared/shared.dart';

class StreakCalculator {
  const StreakCalculator();

  int currentStreak(List<PrayerDay> days) {
    if (days.isEmpty) {
      return 0;
    }

    final sorted = [...days]..sort((a, b) => b.date.compareTo(a.date));

    if (!sorted.first.isComplete) {
      return 0;
    }

    var streak = 0;
    var expectedDate = sorted.first.date;

    for (final day in sorted) {
      if (!day.date.isSameDay(expectedDate)) {
        break;
      }
      if (!day.isComplete) {
        break;
      }
      streak += 1;
      expectedDate = expectedDate.subtract(const Duration(days: 1));
    }

    return streak;
  }
}
