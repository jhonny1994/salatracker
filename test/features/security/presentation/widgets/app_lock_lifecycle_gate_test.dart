import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/security/security.dart';
import 'package:salat_tracker/features/settings/settings.dart';

void main() {
  testWidgets('locks app after background resume when enabled', (tester) async {
    final container = ProviderContainer(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(
          _FakeSettingsRepository(
            Settings.defaults().copyWith(
              onboardingComplete: true,
              appLockEnabled: true,
            ),
          ),
        ),
        securityRepositoryProvider.overrideWithValue(
          _FakeSecurityRepository(hasPinValue: true),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: AppLockLifecycleGate(
            child: SizedBox.shrink(),
          ),
        ),
      ),
    );

    // Wait for async build — starts locked because appLock is enabled
    await container.read(appLockControllerProvider.future);
    expect(
      container.read(appLockControllerProvider).value,
      AppLockStatus.locked,
    );

    // Unlock the app, then verify it re-locks on resume
    container.read(appLockControllerProvider.notifier).unlockApp();
    expect(
      container.read(appLockControllerProvider).value,
      AppLockStatus.unlocked,
    );

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    expect(
      container.read(appLockControllerProvider).value,
      AppLockStatus.locked,
    );
  });

  testWidgets('does not lock when app lock is disabled', (tester) async {
    final container = ProviderContainer(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(
          _FakeSettingsRepository(
            Settings.defaults().copyWith(
              onboardingComplete: true,
              appLockEnabled: false,
            ),
          ),
        ),
        securityRepositoryProvider.overrideWithValue(
          _FakeSecurityRepository(hasPinValue: true, appLockEnabled: false),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: AppLockLifecycleGate(
            child: SizedBox.shrink(),
          ),
        ),
      ),
    );

    // Wait for async build — starts unlocked because appLock is disabled
    await container.read(appLockControllerProvider.future);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    expect(
      container.read(appLockControllerProvider).value,
      AppLockStatus.unlocked,
    );
  });
}

class _FakeSecurityRepository implements SecurityRepository {
  _FakeSecurityRepository({
    required this.hasPinValue,
    this.appLockEnabled = true,
  });

  final bool hasPinValue;
  final bool appLockEnabled;

  @override
  Future<bool> authenticateWithBiometrics({required String reason}) async {
    return false;
  }

  @override
  Future<bool> hasPin() async => hasPinValue;

  @override
  Future<bool> isAppLockEnabled() async => appLockEnabled;

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
  _FakeSettingsRepository(this.settings);

  final Settings settings;

  @override
  Future<Settings> fetchSettings() async => settings;

  @override
  Future<void> saveSettings(Settings settings) async {}

  @override
  Stream<Settings> watchSettings() => Stream.value(settings);
}
