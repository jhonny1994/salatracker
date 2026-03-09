import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/onboarding/onboarding.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';

void main() {
  group('OnboardingScreen', () {
    testWidgets('seeds the late reminder from Isha time', (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(onboardingControllerProvider.notifier).setStepByIndex(2);
      container
          .read(onboardingPrayerTimesProvider.notifier)
          .updateTime(PrayerType.isha, const TimeOfDay(hour: 21, minute: 10));

      await _pumpOnboardingScreen(tester, container: container);

      await tester.tap(find.text('Next').hitTestable());
      await tester.pumpAndSettle();

      expect(find.text('Late-day reminder'), findsOneWidget);
      expect(find.text('23:10'), findsOneWidget);
    });

    testWidgets(
      'keeps selected reminder time through confirmation and completion',
      (
        tester,
      ) async {
        final repo = _FakeSettingsRepository(Settings.defaults());
        final container = ProviderContainer(
          overrides: [settingsRepositoryProvider.overrideWithValue(repo)],
        );
        addTearDown(() {
          container.dispose();
          repo.dispose();
        });

        container.read(onboardingControllerProvider.notifier).setStepByIndex(3);

        await _pumpOnboardingScreen(tester, container: container);

        await tester.tap(find.text('Late-day reminder').hitTestable());
        await tester.pumpAndSettle();
        await _selectTime(tester, hour: '23', minute: '20');

        expect(
          container.read(onboardingLateReminderTimeProvider),
          const TimeOfDay(hour: 23, minute: 20),
        );

        await tester.tap(find.text('Maybe Later').hitTestable());
        await tester.pumpAndSettle();
        expect(find.text('Protect Your Privacy'), findsOneWidget);

        await tester.tap(find.text('Maybe Later').hitTestable());
        await tester.pumpAndSettle();

        expect(find.text("You're All Set"), findsOneWidget);

        await tester.tap(find.text('Get Started').hitTestable());
        await tester.pumpAndSettle();

        expect(repo.settings.onboardingComplete, isTrue);
        expect(
          repo.settings.effectiveDailyReminders.single.time,
          const TimeOfDay(hour: 23, minute: 20),
        );
        expect(find.text('Today Placeholder'), findsOneWidget);
      },
    );
  });
}

Future<void> _pumpOnboardingScreen(
  WidgetTester tester, {
  required ProviderContainer container,
}) async {
  final router = GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/today',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Today Placeholder')),
        ),
      ),
    ],
  );

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
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
        routerConfig: router,
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
