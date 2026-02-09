import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/badges/domain/models/badge_type.dart';
import 'package:salat_tracker/features/badges/domain/services/badge_evaluator.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';

void main() {
  group('BadgeEvaluator', () {
    const evaluator = BadgeEvaluator();

    test('returns empty when no days exist', () {
      final awards = evaluator.evaluate(const []);
      expect(awards, isEmpty);
    });

    test('awards first prayer when any prayer exists', () {
      final day = _day(
        DateTime(2026),
        completedCount: 1,
      );

      final awards = evaluator.evaluate([day]);
      expect(
        awards.map((item) => item.type),
        contains(BadgeType.firstPrayerLogged),
      );
    });

    test('awards week consistency with 7 complete days', () {
      final days = List.generate(
        7,
        (index) => _day(DateTime(2026, 1, index + 1), completedCount: 5),
      );

      final awards = evaluator.evaluate(days);
      expect(
        awards.map((item) => item.type),
        contains(BadgeType.weekConsistency),
      );
    });

    test('awards month complete for >=90 percent completed month', () {
      final january = List.generate(
        31,
        (index) => _day(
          DateTime(2025, 1, index + 1),
          completedCount: index < 28 ? 5 : 0,
        ),
      );

      final awards = evaluator.evaluate(january);
      expect(
        awards.map((item) => item.type),
        contains(BadgeType.monthComplete),
      );
    });

    test('awards season champion for 3 months >=80 percent', () {
      final days = <PrayerDay>[];
      for (var month = 1; month <= 3; month++) {
        final totalDays = DateTime(2025, month + 1, 0).day;
        for (var day = 1; day <= totalDays; day++) {
          days.add(
            _day(
              DateTime(2025, month, day),
              completedCount: day <= (totalDays * 0.8).ceil() ? 5 : 0,
            ),
          );
        }
      }

      final awards = evaluator.evaluate(days);
      expect(
        awards.map((item) => item.type),
        contains(BadgeType.seasonChampion),
      );
    });
  });
}

PrayerDay _day(DateTime date, {required int completedCount}) {
  final entries = PrayerType.values.take(completedCount).map((type) {
    return PrayerEntry(
      type: type,
      scheduledAt: date,
      isCompleted: true,
      checkedAt: date,
    );
  }).toList();

  return PrayerDay.normalized(
    date: date,
    entries: entries,
    isComplete: completedCount == PrayerType.values.length,
    points: 0,
  );
}
