import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/shared/shared.dart';

part 'calendar_controller.g.dart';

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

@riverpod
class SelectedDayController extends _$SelectedDayController {
  @override
  DateTime build() {
    return DateTime.now().dateOnly;
  }

  void selectDay(DateTime day) {
    state = day.dateOnly;
  }
}
