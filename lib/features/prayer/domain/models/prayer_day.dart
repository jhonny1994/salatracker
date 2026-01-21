import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/shared/shared.dart';

part 'prayer_day.freezed.dart';
part 'prayer_day.g.dart';

@freezed
@HiveType(typeId: 3)
abstract class PrayerDay with _$PrayerDay {
  const factory PrayerDay({
    @HiveField(0) required DateTime date,
    @HiveField(1) required List<PrayerEntry> entries,
    @HiveField(2) required bool isComplete,
    @HiveField(3) required int points,
  }) = _PrayerDay;

  factory PrayerDay.normalized({
    required DateTime date,
    required List<PrayerEntry> entries,
    required bool isComplete,
    required int points,
  }) {
    return PrayerDay(
      date: date.dateOnly,
      entries: entries,
      isComplete: isComplete,
      points: points,
    );
  }
}
