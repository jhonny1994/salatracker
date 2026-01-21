import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';

part 'prayer_providers.g.dart';

@Riverpod(keepAlive: true)
PrayerLocalDataSource prayerLocalDataSource(Ref ref) {
  final box = Hive.box<PrayerDay>(HiveService.prayerDaysBoxName);
  return PrayerLocalDataSource(box);
}

@Riverpod(keepAlive: true)
PrayerRepository prayerRepository(Ref ref) {
  return PrayerRepositoryImpl(ref.read(prayerLocalDataSourceProvider));
}

@riverpod
StreakCalculator streakCalculator(Ref ref) {
  return const StreakCalculator();
}

@riverpod
PointsCalculator pointsCalculator(Ref ref) {
  return const PointsCalculator();
}
