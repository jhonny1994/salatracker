import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/shared/shared.dart';

part 'history_controller.g.dart';

/// Controller for managing historical prayer data edits.
///
/// Handles toggling prayer completion for past dates with appropriate
/// warnings and analytics tracking.
@riverpod
class HistoryController extends _$HistoryController {
  @override
  void build() {
    // Stateless controller
  }

  Future<void> togglePrayer({
    required DateTime date,
    required PrayerType prayerType,
  }) async {
    final repository = ref.read(prayerRepositoryProvider);
    final pointsCalculator = ref.read(pointsCalculatorProvider);
    final normalizedDate = date.dateOnly;

    // Fetch existing day or create empty one
    final existingDay = await repository.fetchDay(normalizedDate);
    final currentDay =
        existingDay ??
        PrayerDay.normalized(
          date: normalizedDate,
          entries: [],
          isComplete: false,
          points: 0,
        );

    // Find existing entry
    final existingEntryIndex = currentDay.entries.indexWhere(
      (e) => e.type == prayerType,
    );

    List<PrayerEntry> updatedEntries;

    if (existingEntryIndex >= 0) {
      // Toggle off - remove entry
      updatedEntries = [...currentDay.entries]..removeAt(existingEntryIndex);
    } else {
      // Toggle on - add entry
      // For history, we don't know the exact time, so we use scheduled time
      // (or just 00:00?). We use 12:00 PM normalized for the day as a fallback.
      final now = DateTime.now();
      final timestamp = normalizedDate.add(
        const Duration(hours: 12),
      );

      final newEntry = PrayerEntry(
        type: prayerType,
        scheduledAt: timestamp,
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

    // Log analytics
    if (existingEntryIndex < 0) {
      unawaited(
        ref
            .read(analyticsProvider)
            .logEvent(
              AnalyticsEvent.prayerLogged,
              parameters: {
                AnalyticsParam.prayerType: prayerType.name,
                'is_history_edit': true,
              },
            ),
      );
    }
  }
}
