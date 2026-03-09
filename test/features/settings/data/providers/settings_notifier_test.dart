import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';

void main() {
  group('SettingsNotifier', () {
    test('applies onboarding configuration in one save', () async {
      final repository = _FakeSettingsRepository(
        Settings.defaults().copyWith(notificationsEnabled: false),
      );
      final container = ProviderContainer(
        overrides: [settingsRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      await container.read(settingsProvider.future);

      const reminderTime = TimeOfDay(hour: 21, minute: 45);
      final prayerTimes = {
        PrayerType.fajr: const TimeOfDay(hour: 5, minute: 10),
        PrayerType.dhuhr: const TimeOfDay(hour: 13, minute: 10),
        PrayerType.asr: const TimeOfDay(hour: 16, minute: 40),
        PrayerType.maghrib: const TimeOfDay(hour: 19, minute: 5),
        PrayerType.isha: const TimeOfDay(hour: 20, minute: 35),
      };

      await container
          .read(settingsProvider.notifier)
          .applyOnboardingConfiguration(
            prayerTimes: prayerTimes,
            lateReminderTime: reminderTime,
          );

      expect(repository.saveCount, 1);
      expect(repository.settings.prayerTimes, prayerTimes);
      expect(repository.settings.effectiveDailyReminders, hasLength(1));
      expect(
        repository.settings.effectiveDailyReminders.single.time,
        reminderTime,
      );
      expect(
        repository.settings.effectiveDailyReminders.single.enabled,
        isTrue,
      );
    });

    test('adds, updates, toggles, and removes daily reminders', () async {
      final repository = _FakeSettingsRepository(
        Settings.defaults().copyWith(notificationsEnabled: false),
      );
      final container = ProviderContainer(
        overrides: [settingsRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      await container.read(settingsProvider.future);

      await container
          .read(settingsProvider.notifier)
          .addDailyReminder(time: const TimeOfDay(hour: 23, minute: 0));

      expect(repository.settings.effectiveDailyReminders, hasLength(2));

      final addedReminder = repository.settings.effectiveDailyReminders.last;

      await container
          .read(settingsProvider.notifier)
          .updateDailyReminderTime(
            reminderId: addedReminder.id,
            time: const TimeOfDay(hour: 23, minute: 15),
          );

      expect(
        repository.settings.effectiveDailyReminders.last.time,
        const TimeOfDay(hour: 23, minute: 15),
      );

      await container
          .read(settingsProvider.notifier)
          .toggleDailyReminder(reminderId: addedReminder.id, enabled: false);

      expect(
        repository.settings.effectiveDailyReminders.last.enabled,
        isFalse,
      );

      await container
          .read(settingsProvider.notifier)
          .removeDailyReminder(reminderId: addedReminder.id);

      expect(repository.settings.effectiveDailyReminders, hasLength(1));
    });
  });
}

class _FakeSettingsRepository implements SettingsRepository {
  _FakeSettingsRepository(this.settings);

  Settings settings;
  int saveCount = 0;

  @override
  Future<Settings> fetchSettings() async => settings;

  @override
  Future<void> saveSettings(Settings nextSettings) async {
    saveCount += 1;
    settings = nextSettings;
  }

  @override
  Stream<Settings> watchSettings() => Stream.value(settings);
}
