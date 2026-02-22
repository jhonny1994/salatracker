import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';

void main() {
  group('PrayerRepositoryImpl', () {
    late Directory dir;
    late Box<PrayerDay> box;
    late PrayerRepository repository;

    setUp(() async {
      dir = await Directory.systemTemp.createTemp('prayer_repo_test_');
      Hive.init(dir.path);

      if (!Hive.isAdapterRegistered(PrayerTypeAdapter().typeId)) {
        Hive.registerAdapter(PrayerTypeAdapter());
      }
      if (!Hive.isAdapterRegistered(PrayerEntryAdapter().typeId)) {
        Hive.registerAdapter(PrayerEntryAdapter());
      }
      if (!Hive.isAdapterRegistered(PrayerDayAdapter().typeId)) {
        Hive.registerAdapter(PrayerDayAdapter());
      }

      box = await Hive.openBox<PrayerDay>('prayer_repo_box');
      repository = PrayerRepositoryImpl(PrayerLocalDataSource(box));
    });

    tearDown(() async {
      await box.close();
      await Hive.close();
      await dir.delete(recursive: true);
    });

    test('upserts and fetches a day', () async {
      final date = DateTime(2026);
      final day = PrayerDay.normalized(
        date: date,
        entries: const [],
        isComplete: false,
        points: 0,
      );

      await repository.upsertDay(day);
      final fetched = await repository.fetchDay(date);
      expect(fetched, isNotNull);
      expect(fetched!.date, day.date);
    });

    test('watches updates', () async {
      final date = DateTime(2026);
      final day = PrayerDay.normalized(
        date: date,
        entries: const [],
        isComplete: false,
        points: 0,
      );

      final values = <List<PrayerDay>>[];
      final sub = repository.watchDays().listen(values.add);
      await Future<void>.delayed(const Duration(milliseconds: 10));
      await repository.upsertDay(day);
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(values.isNotEmpty, isTrue);
      expect(values.last, isNotEmpty);
      await sub.cancel();
    });
  });
}
