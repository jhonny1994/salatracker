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

    // Wait for async build — starts locked on cold start because we
    // provided hasPinValue: true and appLockEnabled: true.
    await container.read(appLockControllerProvider.future);
    expect(
      container.read(appLockControllerProvider).value,
      AppLockStatus.locked,
    );

    // Explicitly unlock it first to test the lifecycle gate
    final currentTime = DateTime(2026);
    container.read(appLockControllerProvider.notifier)
      ..clock = (() => currentTime)
      ..unlockApp();
    expect(
      container.read(appLockControllerProvider).value,
      AppLockStatus.unlocked,
    );

    // Simulate background — should lock immediately after the async check
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    // Let the event loop run and resolve `_lockIfNeeded` futures
    await tester.pump(const Duration(milliseconds: 100));

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

    // Simulate background — should NOT lock
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
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
