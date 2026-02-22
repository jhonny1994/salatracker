import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:salat_tracker/core/storage/adapters/time_of_day_adapter.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';

void main() {
  group('SettingsRepositoryImpl', () {
    late Directory dir;
    late Box<Settings> box;
    late SettingsRepository repository;

    setUp(() async {
      dir = await Directory.systemTemp.createTemp('settings_repo_test_');
      Hive.init(dir.path);

      if (!Hive.isAdapterRegistered(AppThemeModeAdapter().typeId)) {
        Hive.registerAdapter(AppThemeModeAdapter());
      }
      if (!Hive.isAdapterRegistered(PrayerTypeAdapter().typeId)) {
        Hive.registerAdapter(PrayerTypeAdapter());
      }
      if (!Hive.isAdapterRegistered(TimeOfDayAdapter().typeId)) {
        Hive.registerAdapter(TimeOfDayAdapter());
      }
      if (!Hive.isAdapterRegistered(SettingsAdapter().typeId)) {
        Hive.registerAdapter(SettingsAdapter());
      }

      box = await Hive.openBox<Settings>('settings_repo_box');
      repository = SettingsRepositoryImpl(SettingsLocalDataSource(box));
    });

    tearDown(() async {
      await box.close();
      await Hive.close();
      await dir.delete(recursive: true);
    });

    test('returns defaults when empty', () async {
      final settings = await repository.fetchSettings();
      expect(settings.onboardingComplete, isFalse);
    });

    test('persists settings values', () async {
      final settings = Settings.defaults().copyWith(
        appLockEnabled: true,
        notificationsEnabled: false,
      );

      await repository.saveSettings(settings);
      final fetched = await repository.fetchSettings();

      expect(fetched.appLockEnabled, isTrue);
      expect(fetched.notificationsEnabled, isFalse);
    });

    test('emits changes from watchSettings', () async {
      final updates = <Settings>[];
      final sub = repository.watchSettings().listen(updates.add);

      await repository.saveSettings(
        Settings.defaults().copyWith(pointsVisible: false),
      );
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(updates, isNotEmpty);
      expect(updates.last.pointsVisible, isFalse);
      await sub.cancel();
    });
  });
}
