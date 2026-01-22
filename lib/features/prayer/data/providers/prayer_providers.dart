import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';

part 'prayer_providers.g.dart';

/// Provider for the prayer local data source.
@Riverpod(keepAlive: true)
PrayerLocalDataSource prayerLocalDataSource(Ref ref) {
  final box = Hive.box<PrayerDay>(HiveService.prayerDaysBoxName);
  return PrayerLocalDataSource(box);
}

/// Provider for the prayer repository.
@Riverpod(keepAlive: true)
PrayerRepository prayerRepository(Ref ref) {
  return PrayerRepositoryImpl(ref.read(prayerLocalDataSourceProvider));
}

/// Provider for the streak calculator service.
@riverpod
StreakCalculator streakCalculator(Ref ref) {
  return const StreakCalculator();
}

/// Provider for the points calculator service.
@riverpod
PointsCalculator pointsCalculator(Ref ref) {
  return const PointsCalculator();
}
