import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/settings/settings.dart';

void main() {
  group('DailyRemindersScreen', () {
    testWidgets('toggles and removes reminders', (tester) async {
      final repo = _FakeSettingsRepository(
        Settings.defaults().copyWith(
          dailyReminders: const [
            DailyReminderConfig.defaultReminder,
            DailyReminderConfig(
              id: 1,
              time: TimeOfDay(hour: 23, minute: 45),
              enabled: true,
            ),
          ],
        ),
      );

      await _pumpDailyRemindersScreen(tester, repo: repo);

      expect(find.text('Reminder 1'), findsOneWidget);
      expect(find.text('Reminder 2'), findsOneWidget);

      await tester.tap(find.byType(Switch).last);
      await tester.pumpAndSettle();

      expect(repo.settings.effectiveDailyReminders.last.enabled, isFalse);

      await tester.tap(find.byIcon(Icons.delete_outline).last);
      await tester.pumpAndSettle();

      expect(repo.settings.effectiveDailyReminders, hasLength(1));
      expect(repo.settings.effectiveDailyReminders.single.id, 0);
      expect(find.text('Reminder 1'), findsOneWidget);

      repo.dispose();
    });

    testWidgets('adds and edits reminders through the time picker', (
      tester,
    ) async {
      final repo = _FakeSettingsRepository(Settings.defaults());

      await _pumpDailyRemindersScreen(tester, repo: repo);

      await tester.tap(find.text('Add Reminder'));
      await tester.pumpAndSettle();
      await _selectTime(tester, hour: '23', minute: '15');

      expect(repo.settings.effectiveDailyReminders, hasLength(2));
      expect(
        repo.settings.effectiveDailyReminders.last.time,
        const TimeOfDay(hour: 23, minute: 15),
      );

      await tester.tap(find.text('Reminder 2'));
      await tester.pumpAndSettle();
      await _selectTime(tester, hour: '21', minute: '40');

      final editedReminder = repo.settings.effectiveDailyReminders.firstWhere(
        (reminder) => reminder.id == 1,
      );
      expect(
        editedReminder.time,
        const TimeOfDay(hour: 21, minute: 40),
      );

      repo.dispose();
    });
  });
}

Future<void> _pumpDailyRemindersScreen(
  WidgetTester tester, {
  required _FakeSettingsRepository repo,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [settingsRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
        locale: const Locale('en'),
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
        home: const DailyRemindersScreen(),
      ),
    ),
  );

  await tester.pumpAndSettle();
}

Future<void> _selectTime(
  WidgetTester tester, {
  required String hour,
  required String minute,
}) async {
  final keyboardButton = find.byIcon(Icons.keyboard_outlined);
  if (keyboardButton.evaluate().isNotEmpty) {
    await tester.tap(keyboardButton.last);
    await tester.pumpAndSettle();
  }

  final inputs = find.byType(EditableText);
  expect(inputs, findsAtLeastNWidgets(2));

  await tester.enterText(inputs.at(0), hour);
  await tester.enterText(inputs.at(1), minute);
  await tester.pump();

  await tester.tap(find.text('OK').last);
  await tester.pumpAndSettle();
}

class _FakeSettingsRepository implements SettingsRepository {
  _FakeSettingsRepository(this._settings);

  Settings _settings;
  final _controller = StreamController<Settings>.broadcast();

  Settings get settings => _settings;

  @override
  Future<Settings> fetchSettings() async => _settings;

  @override
  Future<void> saveSettings(Settings settings) async {
    _settings = settings;
    _controller.add(settings);
  }

  @override
  Stream<Settings> watchSettings() => _controller.stream;

  void dispose() {
    unawaited(_controller.close());
  }
}
