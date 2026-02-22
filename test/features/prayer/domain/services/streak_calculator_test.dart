import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';

void main() {
  group('StreakCalculator', () {
    const calculator = StreakCalculator();

    test('returns zero for empty history', () {
      expect(calculator.currentStreak(const []), 0);
    });

    test('counts streak from yesterday when today is incomplete', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final twoDaysAgo = today.subtract(const Duration(days: 2));

      final days = [
        _day(today, false),
        _day(yesterday, true),
        _day(twoDaysAgo, true),
      ];

      expect(calculator.currentStreak(days), 2);
    });

    test('breaks streak at first incomplete expected day', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final twoDaysAgo = today.subtract(const Duration(days: 2));

      final days = [
        _day(yesterday, true),
        _day(twoDaysAgo, false),
      ];

      expect(calculator.currentStreak(days), 1);
    });
  });
}

PrayerDay _day(DateTime date, bool isComplete) {
  final entries = isComplete
      ? PrayerType.values
            .map(
              (type) => PrayerEntry(
                type: type,
                scheduledAt: date,
                isCompleted: true,
                checkedAt: date,
              ),
            )
            .toList()
      : <PrayerEntry>[];

  return PrayerDay.normalized(
    date: date,
    entries: entries,
    isComplete: isComplete,
    points: 0,
  );
}
