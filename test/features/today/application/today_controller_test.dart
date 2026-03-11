import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/today/today.dart';
import 'package:salat_tracker/shared/shared.dart';

void main() {
  test('markPrayerDone writes completed entry without toggling off', () async {
    final repository = _FakePrayerRepository();
    final container = ProviderContainer(
      overrides: [prayerRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    await container.read(todayControllerProvider.future);

    await container
        .read(todayControllerProvider.notifier)
        .markPrayerDone(PrayerType.fajr);

    expect(repository.savedDays, hasLength(1));
    final firstSave = repository.savedDays.single;
    expect(firstSave.entries, hasLength(1));
    expect(firstSave.entries.single.type, PrayerType.fajr);
    expect(firstSave.entries.single.isCompleted, isTrue);

    await container
        .read(todayControllerProvider.notifier)
        .markPrayerDone(PrayerType.fajr);

    expect(repository.savedDays, hasLength(2));
    final secondSave = repository.savedDays.last;
    expect(
      secondSave.entries.where((entry) => entry.type == PrayerType.fajr),
      hasLength(1),
    );
    expect(
      secondSave.entries
          .firstWhere((entry) => entry.type == PrayerType.fajr)
          .isCompleted,
      isTrue,
    );
  });

  test(
    'markPrayerDone respects explicit date from notification intent',
    () async {
      final repository = _FakePrayerRepository();
      final container = ProviderContainer(
        overrides: [prayerRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      await container.read(todayControllerProvider.future);

      final targetDate = DateTime(2026, 3, 15);
      await container
          .read(todayControllerProvider.notifier)
          .markPrayerDone(PrayerType.isha, date: targetDate);

      final saved = repository.savedDays.single;
      expect(saved.date, DateTime(2026, 3, 15));
      expect(saved.entries.single.type, PrayerType.isha);
    },
  );
}

class _FakePrayerRepository implements PrayerRepository {
  final _days = <DateTime, PrayerDay>{};
  final savedDays = <PrayerDay>[];

  @override
  Future<PrayerDay?> fetchDay(DateTime date) async => _days[date.dateOnly];

  @override
  Future<void> upsertDay(PrayerDay day) async {
    final normalizedDay = day.copyWith(date: day.date.dateOnly);
    _days[normalizedDay.date] = normalizedDay;
    savedDays.add(normalizedDay);
  }

  @override
  Stream<List<PrayerDay>> watchDays() => const Stream.empty();
}
