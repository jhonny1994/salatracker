import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/storage/hive_service.dart';
import 'package:salat_tracker/features/prayer/data/datasources/prayer_local_data_source.dart';
import 'package:salat_tracker/features/prayer/data/repositories/prayer_repository_impl.dart';
import 'package:salat_tracker/features/prayer/domain/models/prayer_day.dart';
import 'package:salat_tracker/features/prayer/domain/repositories/prayer_repository.dart';
import 'package:salat_tracker/features/prayer/domain/services/points_calculator.dart';
import 'package:salat_tracker/features/prayer/domain/services/streak_calculator.dart';

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
