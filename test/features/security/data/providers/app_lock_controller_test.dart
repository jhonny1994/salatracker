import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/security/security.dart';

void main() {
  group('AppLockController', () {
    test('starts unlocked', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(appLockControllerProvider), AppLockStatus.unlocked);
    });

    test('locks and unlocks explicitly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(appLockControllerProvider.notifier);
      _lock(notifier);
      expect(container.read(appLockControllerProvider), AppLockStatus.locked);

      _unlock(notifier);
      expect(container.read(appLockControllerProvider), AppLockStatus.unlocked);
    });
  });
}

void _lock(AppLockController notifier) {
  notifier.lockApp();
}

void _unlock(AppLockController notifier) {
  notifier.unlockApp();
}
