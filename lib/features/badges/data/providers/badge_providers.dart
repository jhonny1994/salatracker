import 'dart:async';

import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/badges/data/datasources/datasources.dart';
import 'package:salat_tracker/features/badges/data/repositories/repositories.dart';
import 'package:salat_tracker/features/badges/domain/domain.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';

part 'badge_providers.g.dart';

@Riverpod(keepAlive: true)
BadgeLocalDataSource badgeLocalDataSource(Ref ref) {
  final box = Hive.box<BadgeAward>(HiveService.badgesBoxName);
  return BadgeLocalDataSource(box);
}

@Riverpod(keepAlive: true)
BadgeRepository badgeRepository(Ref ref) {
  return BadgeRepositoryImpl(ref.watch(badgeLocalDataSourceProvider));
}

@Riverpod(keepAlive: true)
BadgeEvaluator badgeEvaluator(Ref ref) {
  return const BadgeEvaluator();
}

@riverpod
Stream<List<BadgeAward>> badges(Ref ref) async* {
  final prayerRepository = ref.watch(prayerRepositoryProvider);
  final badgeRepository = ref.watch(badgeRepositoryProvider);
  final evaluator = ref.watch(badgeEvaluatorProvider);

  await for (final days in prayerRepository.watchDays()) {
    final awards = evaluator.evaluate(days);
    unawaited(badgeRepository.saveAwards(awards));
    yield awards;
  }
}
