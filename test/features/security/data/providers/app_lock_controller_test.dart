import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/security/security.dart';
import 'package:salat_tracker/features/settings/settings.dart';

void main() {
  group('AppLockController', () {
    test('starts unlocked', () async {
      final container = ProviderContainer(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(
            _FakeSettingsRepository(
              Settings.defaults().copyWith(appLockEnabled: false),
            ),
          ),
          securityRepositoryProvider.overrideWithValue(
            _FakeSecurityRepository(hasPinValue: false),
          ),
        ],
      );
      addTearDown(container.dispose);

      // Wait for async build to complete
      await container.read(appLockControllerProvider.future);

      expect(
        container.read(appLockControllerProvider).value,
        AppLockStatus.unlocked,
      );
    });

    test('locks and unlocks explicitly', () async {
      final container = ProviderContainer(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(
            _FakeSettingsRepository(
              Settings.defaults().copyWith(appLockEnabled: false),
            ),
          ),
          securityRepositoryProvider.overrideWithValue(
            _FakeSecurityRepository(hasPinValue: false),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(appLockControllerProvider.future);

      final notifier = container.read(appLockControllerProvider.notifier)
        ..lockApp();
      expect(
        container.read(appLockControllerProvider).value,
        AppLockStatus.locked,
      );

      notifier.unlockApp();
      expect(
        container.read(appLockControllerProvider).value,
        AppLockStatus.unlocked,
      );
    });
  });
}

class _FakeSecurityRepository implements SecurityRepository {
  _FakeSecurityRepository({required this.hasPinValue});

  final bool hasPinValue;

  @override
  Future<bool> authenticateWithBiometrics({required String reason}) async =>
      false;

  @override
  Future<bool> hasPin() async => hasPinValue;

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
  _FakeSettingsRepository(this.settings);

  final Settings settings;

  @override
  Future<Settings> fetchSettings() async => settings;

  @override
  Future<void> saveSettings(Settings settings) async {}

  @override
  Stream<Settings> watchSettings() => Stream.value(settings);
}
