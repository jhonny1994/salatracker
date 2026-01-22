import 'package:hive_ce/hive.dart';

part 'prayer_type.g.dart';

/// The five daily Islamic prayers.
@HiveType(typeId: 1)
enum PrayerType {
  @HiveField(0)
  fajr,
  @HiveField(1)
  dhuhr,
  @HiveField(2)
  asr,
  @HiveField(3)
  maghrib,
  @HiveField(4)
  isha,
}

extension PrayerTypeX on PrayerType {
  String get key => switch (this) {
    PrayerType.fajr => 'fajr',
    PrayerType.dhuhr => 'dhuhr',
    PrayerType.asr => 'asr',
    PrayerType.maghrib => 'maghrib',
    PrayerType.isha => 'isha',
  };
}
