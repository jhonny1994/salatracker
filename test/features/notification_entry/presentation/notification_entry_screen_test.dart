import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/notification_entry/notification_entry.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';

void main() {
  testWidgets('renders required update variant from explicit intent', (
    tester,
  ) async {
    await _pumpWithRouter(
      tester,
      intent: NotificationIntent.requiredUpdate(
        intentId: 'update_1',
        sourceNotificationId: 1,
      ),
    );

    expect(find.text('Update required to continue'), findsOneWidget);
    expect(find.text('Update now'), findsOneWidget);
  });

  testWidgets('renders badge unlocked variant from explicit intent', (
    tester,
  ) async {
    await _pumpWithRouter(
      tester,
      intent: NotificationIntent.badgeUnlocked(
        intentId: 'badge_1',
        sourceNotificationId: 2,
      ),
    );

    expect(find.text('Badges'), findsOneWidget);
    expect(find.text('Open today'), findsOneWidget);
  });

  testWidgets('renders prayer variant with mark done and snooze actions', (
    tester,
  ) async {
    await _pumpWithRouter(
      tester,
      intent: NotificationIntent.prayer(
        intentId: 'prayer_fajr_1',
        prayerType: PrayerType.fajr,
        date: DateTime(2026, 3, 12),
        scheduledAt: DateTime(2026, 3, 12, 5, 20),
        sourceNotificationId: 3,
      ),
    );

    expect(find.text('Mark as done'), findsOneWidget);
    expect(find.text('Snooze 10 min'), findsOneWidget);
  });
<<<<<<< HEAD
=======

>>>>>>> da3b8b5b44a7d1e337a5999f8c82e72f1a73a5a7
}

Future<void> _pumpWithRouter(
  WidgetTester tester, {
  required NotificationIntent intent,
}) async {
  final router = GoRouter(
    initialLocation: '/notification/entry',
    routes: [
      GoRoute(
        path: '/notification/entry',
        builder: (context, state) => NotificationEntryScreen(
          debugInitialIntent: intent,
          debugDisablePersistence: true,
        ),
      ),
      GoRoute(
        path: '/update-required',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Update Required Route'))),
      ),
      GoRoute(
        path: '/today',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Today Route'))),
      ),
      GoRoute(
        path: '/settings/badges',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Badges Route'))),
      ),
    ],
  );

  addTearDown(router.dispose);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        notificationServiceProvider.overrideWithValue(
          _FakeNotificationService(),
        ),
        prayerRepositoryProvider.overrideWithValue(_FakePrayerRepository()),
      ],
      child: MaterialApp.router(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
        locale: const Locale('en'),
        routerConfig: router,
      ),
    ),
  );

  await tester.pump();
}

class _FakeNotificationService implements NotificationService {
  @override
  Future<void> cancelAll() async {}

  @override
  Future<String?> getLaunchPayload() async => null;

  @override
  Future<void> initialize() async {}

  @override
  Stream<String?> get onNotificationClick => const Stream.empty();

  @override
  Future<void> refreshTimezone({String? preferredTimezoneId}) async {}

  @override
  Future<bool> requestPermissions() async => true;

  @override
  Future<void> schedulePrayer({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAt,
    bool repeatsDaily = false,
    String? payload,
  }) async {}
}

class _FakePrayerRepository implements PrayerRepository {
  @override
  Future<PrayerDay?> fetchDay(DateTime date) async => null;

  @override
  Future<void> upsertDay(PrayerDay day) async {}

  @override
  Stream<List<PrayerDay>> watchDays() => const Stream.empty();
}
