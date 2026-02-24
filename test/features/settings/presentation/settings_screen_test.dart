import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/core/core.dart';

import 'package:salat_tracker/features/security/security.dart';
import 'package:salat_tracker/features/settings/settings.dart';

// ---------------------------------------------------------------------------
// Fake SettingsRepository — in-memory implementation for testing
// ---------------------------------------------------------------------------
class _FakeSettingsRepository implements SettingsRepository {
  Settings _settings = Settings.defaults();
  final _controller = StreamController<Settings>.broadcast();

  @override
  Future<Settings> fetchSettings() async => _settings;

  @override
  Future<void> saveSettings(Settings settings) async {
    _settings = settings;
    _controller.add(settings);
  }

  @override
  Stream<Settings> watchSettings() => _controller.stream;

  void dispose() => _controller.close();
}

// ---------------------------------------------------------------------------
// Fake SecurityRepository
// ---------------------------------------------------------------------------
class _FakeSecurityRepository implements SecurityRepository {
  @override
  Future<void> setPin(String pin) async {}

  @override
  Future<bool> verifyPin(String pin) async => pin == '123456';

  @override
  Future<Duration?> lockoutRemaining() async => null;

  @override
  Future<bool> hasPin() async => false;

  @override
  Future<void> removePin() async {}

  @override
  Future<bool> isAppLockEnabled() async => false;

  @override
  Future<void> setAppLockEnabled({required bool enabled}) async {}

  @override
  Future<bool> authenticateWithBiometrics({required String reason}) async =>
      false;

  @override
  Future<bool> isBiometricsAvailable() async => false;

  @override
  Future<bool> isBiometricUnlockEnabled() async => false;
}

// ---------------------------------------------------------------------------
// Fake NotificationService — no-op stub to avoid native plugin calls
// ---------------------------------------------------------------------------
class _FakeNotificationService extends NotificationService {
  @override
  Future<void> initialize() async {}

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

  @override
  Future<void> cancelAll() async {}

  @override
  Future<void> refreshTimezone({String? preferredTimezoneId}) async {}
}

// Overridden AppLockController that stays unlocked.
class _UnlockedAppLockController extends AppLockController {
  @override
  Future<AppLockStatus> build() async => AppLockStatus.unlocked;
}

// ---------------------------------------------------------------------------
// Helper – scrolls down and taps a SettingsTile found by its title text
// ---------------------------------------------------------------------------
Future<void> _scrollToAndTap(WidgetTester tester, String text) async {
  // Drag the scrollable up repeatedly until the target comes on-screen,
  // then tap the encompassing ListTile rather than just the Text widget.
  final scrollable = find.byType(Scrollable).first;
  for (var i = 0; i < 15; i++) {
    final found = find.text(text).evaluate();
    if (found.isNotEmpty) {
      // Check if the element is actually hittable (within the viewport).
      final box = tester.renderObject(find.text(text)) as RenderBox;
      final pos = box.localToGlobal(box.size.center(Offset.zero));
      final viewSize = tester.view.physicalSize / tester.view.devicePixelRatio;
      if (pos.dy > 60 && pos.dy < viewSize.height - 20) {
        break;
      }
    }
    await tester.drag(scrollable, const Offset(0, -150));
    await tester.pumpAndSettle();
  }
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}

// ---------------------------------------------------------------------------
// Helper – scrolls down until widget with [text] is on-screen
// ---------------------------------------------------------------------------
Future<void> _scrollToVisible(WidgetTester tester, String text) async {
  final scrollable = find.byType(Scrollable).first;
  for (var i = 0; i < 15; i++) {
    if (find.text(text).evaluate().isNotEmpty) {
      final box = tester.renderObject(find.text(text)) as RenderBox;
      final pos = box.localToGlobal(box.size.center(Offset.zero));
      final viewSize = tester.view.physicalSize / tester.view.devicePixelRatio;
      if (pos.dy > 60 && pos.dy < viewSize.height - 20) return;
    }
    await tester.drag(scrollable, const Offset(0, -150));
    await tester.pumpAndSettle();
  }
}

// ---------------------------------------------------------------------------
// Helper to pump the SettingsScreen inside a fully-wired ProviderScope
// ---------------------------------------------------------------------------
Future<_FakeSettingsRepository> _pumpSettingsScreen(
  WidgetTester tester, {
  Settings? initialSettings,
}) async {
  // Resize the test window to a realistic phone size.
  tester.view.physicalSize = const Size(1236, 2745); // 412×915 at 3x
  tester.view.devicePixelRatio = 3.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  final repo = _FakeSettingsRepository();
  if (initialSettings != null) {
    await repo.saveSettings(initialSettings);
  }

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(repo),
        securityRepositoryProvider.overrideWithValue(
          _FakeSecurityRepository(),
        ),
        biometricsAvailableProvider.overrideWith((_) async => false),
        appLockControllerProvider.overrideWith(
          _UnlockedAppLockController.new,
        ),
        notificationServiceProvider.overrideWithValue(
          _FakeNotificationService(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
        locale: const Locale('en'),
        home: const SettingsScreen(),
      ),
    ),
  );

  // Let the async SettingsNotifier.build() complete.
  await tester.pumpAndSettle();
  return repo;
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------
void main() {
  group('SettingsScreen – user flows', () {
    // ── 1. Theme Mode ────────────────────────────────────────────────────
    group('Theme Mode', () {
      testWidgets('shows current theme and can change to Dark', (
        tester,
      ) async {
        final repo = await _pumpSettingsScreen(tester);

        // "System" should be shown as the current theme subtitle.
        expect(find.text('System'), findsOneWidget);

        // Tap the Theme tile.
        await tester.tap(find.text('Theme'));
        await tester.pumpAndSettle();

        // Dialog should show all three options.
        expect(find.text('Light'), findsOneWidget);
        expect(find.text('Dark'), findsOneWidget);
        // System appears in dialog and subtitle = 2.
        expect(find.text('System'), findsNWidgets(2));

        // Select Dark.
        await tester.tap(find.text('Dark'));
        await tester.pumpAndSettle();

        // Verify persisted.
        final saved = await repo.fetchSettings();
        expect(saved.themeMode, AppThemeMode.dark);

        repo.dispose();
      });

      testWidgets('can change to Light', (tester) async {
        final repo = await _pumpSettingsScreen(tester);

        await tester.tap(find.text('Theme'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Light'));
        await tester.pumpAndSettle();

        final saved = await repo.fetchSettings();
        expect(saved.themeMode, AppThemeMode.light);

        repo.dispose();
      });
    });

    // ── 2. Language ──────────────────────────────────────────────────────
    group('Language', () {
      testWidgets('can switch to French', (tester) async {
        final repo = await _pumpSettingsScreen(tester);

        await tester.tap(find.text('Language'));
        await tester.pumpAndSettle();

        expect(find.text('French'), findsOneWidget);

        await tester.tap(find.text('French'));
        await tester.pumpAndSettle();

        final saved = await repo.fetchSettings();
        expect(saved.localeCode, 'fr');

        repo.dispose();
      });

      testWidgets('can switch to Arabic', (tester) async {
        final repo = await _pumpSettingsScreen(tester);

        await tester.tap(find.text('Language'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Arabic'));
        await tester.pumpAndSettle();

        final saved = await repo.fetchSettings();
        expect(saved.localeCode, 'ar');

        repo.dispose();
      });
    });

    // ── 3. Week Start ────────────────────────────────────────────────────
    group('Week Start', () {
      testWidgets('defaults to Sunday and can change to Saturday', (
        tester,
      ) async {
        final repo = await _pumpSettingsScreen(tester);

        expect(find.text('Sunday'), findsOneWidget);

        await tester.tap(find.text('Week Start'));
        await tester.pumpAndSettle();

        expect(find.text('Saturday'), findsOneWidget);
        expect(find.text('Monday'), findsOneWidget);

        await tester.tap(find.text('Saturday'));
        await tester.pumpAndSettle();

        final saved = await repo.fetchSettings();
        expect(saved.weekStart, DateTime.saturday);

        repo.dispose();
      });

      testWidgets('can change to Monday', (tester) async {
        final repo = await _pumpSettingsScreen(tester);

        await tester.tap(find.text('Week Start'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Monday'));
        await tester.pumpAndSettle();

        final saved = await repo.fetchSettings();
        expect(saved.weekStart, DateTime.monday);

        repo.dispose();
      });
    });

    // ── 4. Haptics ───────────────────────────────────────────────────────
    group('Haptics', () {
      testWidgets('defaults to enabled and can be disabled', (tester) async {
        final repo = await _pumpSettingsScreen(tester);

        await _scrollToAndTap(tester, 'Haptic Feedback');

        final dialogEnabledFinder = find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text('Enabled'),
        );
        final dialogDisabledFinder = find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text('Disabled'),
        );

        expect(dialogEnabledFinder, findsOneWidget);
        expect(dialogDisabledFinder, findsOneWidget);

        await tester.tap(dialogDisabledFinder);
        await tester.pumpAndSettle();

        final saved = await repo.fetchSettings();
        expect(saved.hapticsEnabled, isFalse);

        repo.dispose();
      });

      testWidgets('can be re-enabled after disabling', (tester) async {
        final repo = await _pumpSettingsScreen(
          tester,
          initialSettings: Settings.defaults().copyWith(hapticsEnabled: false),
        );

        await _scrollToAndTap(tester, 'Haptic Feedback');

        await tester.tap(
          find.descendant(
            of: find.byType(AlertDialog),
            matching: find.text('Enabled'),
          ),
        );
        await tester.pumpAndSettle();

        final saved = await repo.fetchSettings();
        expect(saved.hapticsEnabled, isTrue);

        repo.dispose();
      });
    });

    // ── 5. Notifications ─────────────────────────────────────────────────
    group('Notifications', () {
      testWidgets('shows dialog and persists toggle off', (tester) async {
        final repo = await _pumpSettingsScreen(
          tester,
          initialSettings: Settings.defaults().copyWith(
            notificationsEnabled: true,
          ),
        );

        await _scrollToAndTap(tester, 'Notifications');

        final dialogEnabledFinder = find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text('Enabled'),
        );
        final dialogDisabledFinder = find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text('Disabled'),
        );

        expect(dialogEnabledFinder, findsOneWidget);
        expect(dialogDisabledFinder, findsOneWidget);

        await tester.tap(dialogDisabledFinder);
        await tester.pumpAndSettle();

        final saved = await repo.fetchSettings();
        expect(saved.notificationsEnabled, isFalse);

        repo.dispose();
      });
    });

    // ── 6. App Lock ──────────────────────────────────────────────────────
    group('App Lock', () {
      testWidgets('toggle dialog shows Yes/No', (tester) async {
        final repo = await _pumpSettingsScreen(tester);

        await _scrollToAndTap(tester, 'App Lock');

        final dialogEnabledFinder = find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text('Enabled'),
        );
        final dialogDisabledFinder = find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text('Disabled'),
        );

        expect(dialogEnabledFinder, findsOneWidget);
        expect(dialogDisabledFinder, findsOneWidget);

        // Dismiss without changing.
        await tester.tapAt(Offset.zero);
        await tester.pumpAndSettle();

        final saved = await repo.fetchSettings();
        expect(saved.appLockEnabled, isFalse);

        repo.dispose();
      });

      testWidgets('disabling app lock updates setting', (tester) async {
        final repo = await _pumpSettingsScreen(
          tester,
          initialSettings: Settings.defaults().copyWith(appLockEnabled: true),
        );

        await _scrollToAndTap(tester, 'App Lock');

        await tester.tap(
          find.descendant(
            of: find.byType(AlertDialog),
            matching: find.text('Disabled'),
          ),
        );
        await tester.pumpAndSettle();

        final saved = await repo.fetchSettings();
        expect(saved.appLockEnabled, isFalse);

        repo.dispose();
      });
    });

    // ── 7. Biometric Unlock (visibility gated by appLockEnabled) ─────────
    group('Biometric Unlock', () {
      testWidgets('not visible when app lock is disabled', (tester) async {
        await _pumpSettingsScreen(tester);

        expect(find.text('Biometric Unlock'), findsNothing);
      });

      testWidgets('visible when app lock is enabled', (tester) async {
        final repo = await _pumpSettingsScreen(
          tester,
          initialSettings: Settings.defaults().copyWith(appLockEnabled: true),
        );

        await _scrollToVisible(tester, 'Biometric Unlock');
        expect(find.text('Biometric Unlock'), findsOneWidget);

        repo.dispose();
      });
    });

    // ── 8. Reset PIN (visibility gated by appLockEnabled) ────────────────
    group('Reset PIN', () {
      testWidgets('not visible when app lock is disabled', (tester) async {
        await _pumpSettingsScreen(tester);

        expect(find.text('Reset PIN'), findsNothing);
      });

      testWidgets('visible when app lock is enabled', (tester) async {
        final repo = await _pumpSettingsScreen(
          tester,
          initialSettings: Settings.defaults().copyWith(appLockEnabled: true),
        );

        await _scrollToVisible(tester, 'Reset PIN');
        expect(find.text('Reset PIN'), findsOneWidget);

        repo.dispose();
      });
    });

    // ── 9. Prayer Schedule navigation tile ───────────────────────────────
    group('Prayer Schedule', () {
      testWidgets('tile is visible and tappable', (tester) async {
        await _pumpSettingsScreen(tester);

        await _scrollToAndTap(tester, 'Prayer Schedule');
        // Just verify no crash on tap.
      });
    });

    // ── 10. Badges navigation tile ───────────────────────────────────────
    group('Badges', () {
      testWidgets('tile is visible and tappable', (tester) async {
        await _pumpSettingsScreen(tester);

        await _scrollToAndTap(tester, 'Badges');
        // Just verify no crash on tap.
      });
    });

    // ── 11. App Version ──────────────────────────────────────────────────
    group('App Version', () {
      testWidgets('shows version info tile', (tester) async {
        await _pumpSettingsScreen(tester);

        await _scrollToVisible(tester, 'App Version');
        expect(find.text('App Version'), findsOneWidget);
      });
    });

    // ── 12. Cross-cutting: settings persist across rebuild ───────────────
    group('Persistence', () {
      testWidgets('multiple settings changes accumulate correctly', (
        tester,
      ) async {
        final repo = await _pumpSettingsScreen(tester);

        // Change theme to Dark.
        await tester.tap(find.text('Theme'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Dark'));
        await tester.pumpAndSettle();

        // Change week start to Monday.
        await tester.tap(find.text('Week Start'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Monday'));
        await tester.pumpAndSettle();

        // Disable haptics (need to scroll down).
        await _scrollToAndTap(tester, 'Haptic Feedback');
        await tester.tap(
          find.descendant(
            of: find.byType(AlertDialog),
            matching: find.text('Disabled'),
          ),
        );
        await tester.pumpAndSettle();

        // Verify all three changes persisted in one Settings object.
        final saved = await repo.fetchSettings();
        expect(saved.themeMode, AppThemeMode.dark);
        expect(saved.weekStart, DateTime.monday);
        expect(saved.hapticsEnabled, isFalse);

        // Verify other settings remained at defaults.
        expect(saved.notificationsEnabled, isFalse);
        expect(saved.appLockEnabled, isFalse);
        expect(saved.biometricUnlockEnabled, isTrue);
        expect(saved.onboardingComplete, isFalse);
        expect(saved.localeCode, isNull);

        repo.dispose();
      });
    });

    // ── 13. Error state ──────────────────────────────────────────────────
    group('Error state', () {
      testWidgets('shows error state when settings fail to load', (
        tester,
      ) async {
        tester.view.physicalSize = const Size(1236, 2745);
        tester.view.devicePixelRatio = 3.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              settingsRepositoryProvider.overrideWithValue(
                _FailingSettingsRepository(),
              ),
              securityRepositoryProvider.overrideWithValue(
                _FakeSecurityRepository(),
              ),
              biometricsAvailableProvider.overrideWith((_) async => false),
              appLockControllerProvider.overrideWith(
                _UnlockedAppLockController.new,
              ),
              notificationServiceProvider.overrideWithValue(
                _FakeNotificationService(),
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: supportedLocales,
              locale: const Locale('en'),
              home: const SettingsScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Should show an error state instead of settings tiles.
        expect(find.text('Theme'), findsNothing);
      });
    });

    // ── 14. Section headers ──────────────────────────────────────────────
    group('Layout and sections', () {
      testWidgets('all section headers are rendered', (tester) async {
        await _pumpSettingsScreen(tester);

        expect(find.text('Appearance'), findsOneWidget);
        expect(find.text('Preferences'), findsOneWidget);

        await _scrollToVisible(tester, 'About');
        expect(find.text('About'), findsOneWidget);
      });
    });
  });
}

// ---------------------------------------------------------------------------
// Failing repository to test error state
// ---------------------------------------------------------------------------
class _FailingSettingsRepository implements SettingsRepository {
  @override
  Future<Settings> fetchSettings() async =>
      throw Exception('Storage corrupted');

  @override
  Future<void> saveSettings(Settings settings) async =>
      throw Exception('Storage corrupted');

  @override
  Stream<Settings> watchSettings() =>
      Stream.error(Exception('Storage corrupted'));
}
