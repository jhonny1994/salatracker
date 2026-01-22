import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Calculates prayer completion streaks.
///
/// Counts consecutive days of complete prayer tracking, handling the case
/// where today is in progress (ignoring it for streak calculations).
class StreakCalculator {
  const StreakCalculator();

  /// Calculates the current streak from a list of prayer days.
  ///
  /// Returns the number of consecutive complete days, ending yesterday
  /// or today (if today is complete).
  int currentStreak(List<PrayerDay> days) {
    if (days.isEmpty) {
      return 0;
    }

    // Sort descending (newest first)
    final sorted = [...days]..sort((a, b) => b.date.compareTo(a.date));
    final today = DateTime.now().dateOnly;

    var streak = 0;
    // We start expecting either Today or Yesterday depending on completion
    var currentDayToCheckIdx = 0;

    if (sorted.isEmpty) return 0;

    final newest = sorted.first;

    // Logic:
    // 1. If we have data for Today, check its status.
    // 2. If Today is complete: Good, count it, next expected
    //    is Yesterday.
    // 3. If Today is NOT complete: Don't break streak yet.
    //    Ignore Today, check Yesterday.
    // 4. If we don't have Today (newest is old), assume Today
    //    is 0 progress (ignored), check Yesterday.

    var expectedDate = today;

    // If the newest record is Today
    if (newest.date.isSameDay(today)) {
      if (newest.isComplete) {
        // Today is done!
        streak++;
        expectedDate = today.subtract(const Duration(days: 1));
        currentDayToCheckIdx = 1; // Move to next
      } else {
        // Today is in progress. Skip it for streak,
        // check Yesterday.
        expectedDate = today.subtract(const Duration(days: 1));
        currentDayToCheckIdx = 1;
      }
    } else {
      // Newest is not Today (it's older).
      // Start checking from Yesterday.
      expectedDate = today.subtract(const Duration(days: 1));
      currentDayToCheckIdx = 0;
    }

    // Loop through remaining history
    for (var i = currentDayToCheckIdx; i < sorted.length; i++) {
      final day = sorted[i];

      // Optimization: If we skipped way past the expected date, break.
      if (day.date.isBefore(expectedDate)) {
        // Gap detected
        break;
      }

      if (day.date.isSameDay(expectedDate)) {
        if (day.isComplete) {
          streak++;
          expectedDate = expectedDate.subtract(const Duration(days: 1));
        } else {
          // Break streak
          break;
        }
      }
    }

    return streak;
  }
}
