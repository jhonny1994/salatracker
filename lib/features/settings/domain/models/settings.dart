import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
@HiveType(typeId: 4)
abstract class Settings with _$Settings {
  const factory Settings({
    @HiveField(0) required Map<PrayerType, int> prayerTimes,
    @HiveField(1) required Map<PrayerType, int> offsets,
    @HiveField(2) required bool notificationsEnabled,
    @HiveField(3) required bool hapticsEnabled,
    @HiveField(4) required bool pointsVisible,
    @HiveField(5) required AppThemeMode themeMode,
    @HiveField(6) required String? localeCode,
    @HiveField(7) required int weekStart,
  }) = _Settings;

  factory Settings.defaults() {
    final defaultTimes = {
      for (final type in PrayerType.values) type: 0,
    };
    return Settings(
      prayerTimes: defaultTimes,
      offsets: {
        for (final type in PrayerType.values) type: 0,
      },
      notificationsEnabled: false,
      hapticsEnabled: true,
      pointsVisible: true,
      themeMode: AppThemeMode.system,
      localeCode: null,
      weekStart: DateTime.sunday,
    );
  }
}
