import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/features/prayer/data/providers/prayer_providers.dart';
import 'package:salat_tracker/features/prayer/domain/models/prayer_day.dart';
import 'package:salat_tracker/features/prayer/domain/models/prayer_entry.dart';
import 'package:salat_tracker/features/prayer/domain/models/prayer_type.dart';
import 'package:salat_tracker/shared/shared.dart';

part 'today_controller.g.dart';

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
      (PrayerEntry e) => e.type == prayerType,
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
        updatedEntries.every((PrayerEntry e) => e.isCompleted);

    final updatedDay = currentDay.copyWith(
      entries: updatedEntries,
      isComplete: isComplete,
    );

    // Calculate points using the updated day
    final points = pointsCalculator.forDay(updatedDay);
    final finalDay = updatedDay.copyWith(points: points);

    await repository.upsertDay(finalDay);
    state = AsyncData(finalDay);
  }
}
