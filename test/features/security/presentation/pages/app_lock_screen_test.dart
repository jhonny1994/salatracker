import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/security/security.dart';

void main() {
  testWidgets(
    'shows lockout message when active lockout exists',
    (tester) async {
      final container = ProviderContainer(
        overrides: [
          securityRepositoryProvider.overrideWithValue(
            _FakeSecurityRepository(lockout: const Duration(seconds: 30)),
          ),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: _testApp(const AppLockScreen()),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.textContaining('30'), findsOneWidget);
    },
  );

  testWidgets('unlocks after entering valid pin', (tester) async {
    final container = ProviderContainer(
      overrides: [
        securityRepositoryProvider.overrideWithValue(
          _FakeSecurityRepository(validPin: '123456'),
        ),
      ],
    );
    addTearDown(container.dispose);

    container.read(appLockControllerProvider.notifier).lockApp();

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _testApp(const AppLockScreen()),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('3'));
    await tester.tap(find.text('4'));
    await tester.tap(find.text('5'));
    await tester.tap(find.text('6'));
    await tester.pumpAndSettle();

    expect(container.read(appLockControllerProvider), AppLockStatus.unlocked);
  });
}

Widget _testApp(Widget child) {
  return MaterialApp(
    home: child,
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: supportedLocales,
  );
}

class _FakeSecurityRepository implements SecurityRepository {
  _FakeSecurityRepository({this.validPin = '', this.lockout});

  final String validPin;
  final Duration? lockout;

  @override
  Future<bool> authenticateWithBiometrics({required String reason}) async {
    return false;
  }

  @override
  Future<bool> hasPin() async => true;

  @override
  Future<bool> isAppLockEnabled() async => true;

  @override
  Future<bool> isBiometricsAvailable() async => false;

  @override
  Future<bool> isBiometricUnlockEnabled() async => false;

  @override
  Future<Duration?> lockoutRemaining() async => lockout;

  @override
  Future<void> removePin() async {}

  @override
  Future<void> setAppLockEnabled({required bool enabled}) async {}

  @override
  Future<void> setPin(String pin) async {}

  @override
  Future<bool> verifyPin(String pin) async => pin == validPin;
}
