import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/shared/shared.dart';

part 'calendar_controller.g.dart';

/// Provider exposing a reactive map of prayer days keyed by date.
///
/// Transforms the prayer days list into a map for efficient date lookups
/// in calendar rendering.
@riverpod
Stream<Map<DateTime, PrayerDay>> calendarDays(Ref ref) {
  final repository = ref.watch(prayerRepositoryProvider);

  return repository.watchDays().map((List<PrayerDay> days) {
    // Convert list to map keyed by normalized date
    return <DateTime, PrayerDay>{
      for (final day in days) day.date.dateOnly: day,
    };
  });
}

/// Controller managing the currently selected day in the calendar.
///
/// Tracks which day the user has selected for detailed viewing and logs
/// analytics events for history navigation.
@riverpod
class SelectedDayController extends _$SelectedDayController {
  @override
  DateTime build() {
    return DateTime.now().dateOnly;
  }

  void selectDay(DateTime day) {
    state = day.dateOnly;
    unawaited(
      ref
          .read(analyticsProvider)
          .logEvent(
            AnalyticsEvent.historyViewed,
            parameters: {
              AnalyticsParam.month: day.month,
              AnalyticsParam.year: day.year,
            },
          ),
    );
  }
}
