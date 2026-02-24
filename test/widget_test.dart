import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/security/security.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/main.dart';

void main() {
  testWidgets('App builds', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(
            _FakeSettingsRepository(),
          ),
          securityRepositoryProvider.overrideWithValue(
            _FakeSecurityRepository(),
          ),
        ],
        child: const SalatTrackerApp(),
      ),
    );

    // pumpAndSettle to clear flutter_animate timers
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

class _FakeSecurityRepository implements SecurityRepository {
  @override
  Future<bool> authenticateWithBiometrics({required String reason}) async =>
      false;

  @override
  Future<bool> hasPin() async => false;

  @override
  Future<bool> isAppLockEnabled() async => false;

  @override
  Future<bool> isBiometricsAvailable() async => false;

  @override
  Future<bool> isBiometricUnlockEnabled() async => false;

  @override
  Future<Duration?> lockoutRemaining() async => null;

  @override
  Future<void> removePin() async {}

  @override
  Future<void> setAppLockEnabled({required bool enabled}) async {}

  @override
  Future<void> setPin(String pin) async {}

  @override
  Future<bool> verifyPin(String pin) async => false;
}

class _FakeSettingsRepository implements SettingsRepository {
  @override
  Future<Settings> fetchSettings() async => Settings.defaults();

  @override
  Future<void> saveSettings(Settings settings) async {}

  @override
  Stream<Settings> watchSettings() => Stream.value(Settings.defaults());
}
