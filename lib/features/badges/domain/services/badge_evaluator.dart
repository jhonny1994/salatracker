import 'package:salat_tracker/features/badges/domain/models/badge_award.dart';
import 'package:salat_tracker/features/badges/domain/models/badge_type.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/shared/shared.dart';

class BadgeEvaluator {
  const BadgeEvaluator();

  List<BadgeAward> evaluate(List<PrayerDay> days) {
    if (days.isEmpty) {
      return const [];
    }

    final sortedDays = [...days]..sort((a, b) => a.date.compareTo(b.date));
    final awards = <BadgeAward>[];

    final firstPrayer = _firstPrayerAward(sortedDays);
    if (firstPrayer != null) {
      awards.add(firstPrayer);
    }

    final week = _weekConsistencyAward(sortedDays);
    if (week != null) {
      awards.add(week);
    }

    final month = _monthCompleteAward(sortedDays);
    if (month != null) {
      awards.add(month);
    }

    final season = _seasonChampionAward(sortedDays);
    if (season != null) {
      awards.add(season);
    }

    awards.sort((a, b) => a.earnedAt.compareTo(b.earnedAt));
    return awards;
  }

  BadgeAward? _firstPrayerAward(List<PrayerDay> sortedDays) {
    for (final day in sortedDays) {
      if (day.entries.any((entry) => entry.isCompleted)) {
        return BadgeAward(
          type: BadgeType.firstPrayerLogged,
          earnedAt: day.date,
        );
      }
    }
    return null;
  }

  BadgeAward? _weekConsistencyAward(List<PrayerDay> sortedDays) {
    final completeDays = sortedDays.where((day) => day.isComplete).toList();
    if (completeDays.length < 7) {
      return null;
    }

    return BadgeAward(
      type: BadgeType.weekConsistency,
      earnedAt: completeDays[6].date,
    );
  }

  BadgeAward? _monthCompleteAward(List<PrayerDay> sortedDays) {
    final now = DateTime.now();
    final grouped = _groupByMonth(sortedDays);
    final keys = grouped.keys.toList()
      ..sort((a, b) {
        if (a.$1 != b.$1) {
          return a.$1.compareTo(b.$1);
        }
        return a.$2.compareTo(b.$2);
      });

    for (final key in keys) {
      final year = key.$1;
      final month = key.$2;

      if (year == now.year && month == now.month) {
        continue;
      }

      final days = grouped[key]!;
      final completeCount = days.where((day) => day.isComplete).length;
      final totalDays = DateTime(year, month + 1, 0).day;
      final ratio = completeCount / totalDays;

      if (ratio >= 0.9) {
        return BadgeAward(
          type: BadgeType.monthComplete,
          earnedAt: DateTime(year, month, totalDays).dateOnly,
        );
      }
    }

    return null;
  }

  BadgeAward? _seasonChampionAward(List<PrayerDay> sortedDays) {
    final now = DateTime.now();
    final grouped = _groupByMonth(sortedDays);
    final keys = grouped.keys.toList()
      ..sort((a, b) {
        if (a.$1 != b.$1) {
          return a.$1.compareTo(b.$1);
        }
        return a.$2.compareTo(b.$2);
      });

    final qualifyingMonths = <(int, int)>[];

    for (final key in keys) {
      final year = key.$1;
      final month = key.$2;

      if (year == now.year && month == now.month) {
        continue;
      }

      final days = grouped[key]!;
      final completeCount = days.where((day) => day.isComplete).length;
      final totalDays = DateTime(year, month + 1, 0).day;
      final ratio = completeCount / totalDays;

      if (ratio >= 0.8) {
        qualifyingMonths.add((year, month));
      }
    }

    if (qualifyingMonths.length < 3) {
      return null;
    }

    final third = qualifyingMonths[2];
    final endOfMonth = DateTime(third.$1, third.$2 + 1, 0);
    return BadgeAward(
      type: BadgeType.seasonChampion,
      earnedAt: endOfMonth.dateOnly,
    );
  }

  Map<(int, int), List<PrayerDay>> _groupByMonth(List<PrayerDay> days) {
    final map = <(int, int), List<PrayerDay>>{};
    for (final day in days) {
      final key = (day.date.year, day.date.month);
      map.putIfAbsent(key, () => <PrayerDay>[]).add(day);
    }
    return map;
  }
}
