import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';

void main() {
  group('PointsCalculator', () {
    const calculator = PointsCalculator();

    test('returns zero when no entries are completed', () {
      final day = PrayerDay.normalized(
        date: DateTime(2026),
        entries: const [],
        isComplete: false,
        points: 0,
      );

      expect(calculator.forDay(day), 0);
    });

    test('awards 10 points per completed prayer', () {
      final date = DateTime(2026);
      final entries = PrayerType.values.take(3).map((type) {
        return PrayerEntry(
          type: type,
          scheduledAt: date,
          isCompleted: true,
          checkedAt: date,
        );
      }).toList();

      final day = PrayerDay.normalized(
        date: date,
        entries: entries,
        isComplete: false,
        points: 0,
      );

      expect(calculator.forDay(day), 35);
    });

    test('adds daily bonus when all entries are completed', () {
      final date = DateTime(2026);
      final entries = PrayerType.values.map((type) {
        return PrayerEntry(
          type: type,
          scheduledAt: date,
          isCompleted: true,
          checkedAt: date,
        );
      }).toList();

      final day = PrayerDay.normalized(
        date: date,
        entries: entries,
        isComplete: true,
        points: 0,
      );

      expect(calculator.forDay(day), 55);
    });
  });
}
