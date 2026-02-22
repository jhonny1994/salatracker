import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/shared/shared.dart';

part 'today_controller.g.dart';

/// Controller managing today's prayer day state.
///
/// Provides the current day's prayer data and handles toggling prayer
/// completion with analytics tracking.
@riverpod
class TodayController extends _$TodayController {
  @override
  Future<PrayerDay> build() async {
    final repository = ref.watch(prayerRepositoryProvider);
    final today = DateTime.now().dateOnly;

    final existingDay = await repository.fetchDay(today);
    if (existingDay != null) {
      return existingDay;
    }

    // Create an empty day for today
    return PrayerDay.normalized(
      date: today,
      entries: [],
      isComplete: false,
      points: 0,
    );
  }

  Future<void> togglePrayer(PrayerType prayerType) async {
    final currentState = state;
    if (currentState is! AsyncData<PrayerDay>) return;
    final currentDay = currentState.value;

    final repository = ref.read(prayerRepositoryProvider);
    final pointsCalculator = ref.read(pointsCalculatorProvider);

    final existingEntryIndex = currentDay.entries.indexWhere(
      (e) => e.type == prayerType,
    );

    List<PrayerEntry> updatedEntries;

    if (existingEntryIndex >= 0) {
      // Toggle off - remove entry
      updatedEntries = [...currentDay.entries]..removeAt(existingEntryIndex);
    } else {
      // Toggle on - add entry
      final now = DateTime.now();
      final newEntry = PrayerEntry(
        type: prayerType,
        scheduledAt: now,
        isCompleted: true,
        checkedAt: now,
      );
      updatedEntries = [...currentDay.entries, newEntry];
    }

    final isComplete =
        updatedEntries.length == PrayerType.values.length &&
        updatedEntries.every((e) => e.isCompleted);

    final updatedDay = currentDay.copyWith(
      entries: updatedEntries,
      isComplete: isComplete,
    );

    // Calculate points using the updated day
    final points = pointsCalculator.forDay(updatedDay);
    final finalDay = updatedDay.copyWith(points: points);

    await repository.upsertDay(finalDay);
    state = AsyncData(finalDay);

    // Track analytics (Fire and forget)
    if (existingEntryIndex < 0) {
      // Only track when logging (not unlogging)
      final analytics = ref.read(analyticsProvider);

      unawaited(
        analytics.logEvent(
          AnalyticsEvent.prayerLogged,
          parameters: {
            AnalyticsParam.prayerType: prayerType.name,
          },
        ),
      );
    }
  }
}
