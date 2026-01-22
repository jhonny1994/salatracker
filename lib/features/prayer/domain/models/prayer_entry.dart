import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';

part 'prayer_entry.freezed.dart';
part 'prayer_entry.g.dart';

/// A single prayer's completion record.
///
/// Tracks the prayer type, scheduled time, completion status, and when
/// it was checked off.
@freezed
@HiveType(typeId: 2)
abstract class PrayerEntry with _$PrayerEntry {
  const factory PrayerEntry({
    @HiveField(0) required PrayerType type,
    @HiveField(1) required DateTime scheduledAt,
    @HiveField(2) required bool isCompleted,
    @HiveField(3) DateTime? checkedAt,
  }) = _PrayerEntry;
}
