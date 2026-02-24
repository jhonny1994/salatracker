import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:salat_tracker/features/security/data/repositories/security_repository_impl.dart';
import 'package:salat_tracker/features/security/data/services/services.dart';
import 'package:salat_tracker/features/settings/settings.dart';

void main() {
  group('SecurityRepositoryImpl', () {
    late _InMemorySecureStore store;
    late _FakeBiometricAuthService biometrics;
    late _FakeSettingsRepository settingsRepository;
    late DateTime now;

    SecurityRepositoryImpl buildRepository() {
      return SecurityRepositoryImpl(
        secureStorage: store,
        biometricAuthService: biometrics,
        settingsRepository: settingsRepository,
        now: () => now,
      );
    }

    setUp(() {
      store = _InMemorySecureStore();
      biometrics = _FakeBiometricAuthService();
      settingsRepository = _FakeSettingsRepository();
      now = DateTime(2026, 2, 10, 12);
    });

    test('stores hash and verifies pin', () async {
      final repository = buildRepository();
      await repository.setPin('1234');

      expect(await repository.hasPin(), isTrue);
      expect(await repository.verifyPin('1234'), isTrue);
      expect(await repository.verifyPin('0000'), isFalse);
    });

    test('migrates legacy plaintext pin on successful verify', () async {
      final repository = buildRepository();
      await store.write(key: 'user_pin', value: '1234');

      final valid = await repository.verifyPin('1234');
      expect(valid, isTrue);
      expect(await store.read(key: 'user_pin'), isNull);
      expect(await store.read(key: 'pin_hash_v1'), isNotNull);
      expect(await store.read(key: 'pin_salt_v1'), isNotNull);
    });

    test('locks out after five invalid attempts', () async {
      final repository = buildRepository();
      await repository.setPin('1234');

      for (var i = 0; i < 5; i++) {
        expect(await repository.verifyPin('0000'), isFalse);
      }

      final remaining = await repository.lockoutRemaining();
      expect(remaining, isNotNull);
      expect(remaining!.inSeconds, greaterThan(0));
      expect(await repository.verifyPin('1234'), isFalse);
    });

    test(
      'successful pin clears failed attempts before lockout threshold',
      () async {
        final repository = buildRepository();
        await repository.setPin('1234');

        await repository.verifyPin('0000');
        await repository.verifyPin('0000');
        expect(await repository.lockoutRemaining(), isNull);

        expect(await repository.verifyPin('1234'), isTrue);

        for (var i = 0; i < 4; i++) {
          expect(await repository.verifyPin('0000'), isFalse);
        }
        expect(await repository.lockoutRemaining(), isNull);
      },
    );

    test('lockout expires based on injected time source', () async {
      final repository = buildRepository();
      await repository.setPin('1234');

      for (var i = 0; i < 5; i++) {
        await repository.verifyPin('0000');
      }

      expect(await repository.lockoutRemaining(), isNotNull);
      now = now.add(const Duration(minutes: 3));
      expect(await repository.lockoutRemaining(), isNull);
      expect(await repository.verifyPin('1234'), isTrue);
    });

    test('updates app lock enabled via settings repository', () async {
      final repository = buildRepository();

      expect(await repository.isAppLockEnabled(), isFalse);
      await repository.setAppLockEnabled(enabled: true);
      expect(await repository.isAppLockEnabled(), isTrue);
    });

    test('reads biometric unlock preference from settings', () async {
      final repository = buildRepository();

      expect(await repository.isBiometricUnlockEnabled(), isTrue);
      await settingsRepository.saveSettings(
        Settings.defaults().copyWith(biometricUnlockEnabled: false),
      );
      expect(await repository.isBiometricUnlockEnabled(), isFalse);
    });

    test('biometric auth respects availability', () async {
      final repository = buildRepository();

      biometrics
        ..canCheck = false
        ..supported = true
        ..result = true;
      expect(
        await repository.authenticateWithBiometrics(reason: 'Unlock'),
        isFalse,
      );

      biometrics
        ..canCheck = true
        ..supported = true
        ..result = true;
      expect(
        await repository.authenticateWithBiometrics(reason: 'Unlock'),
        isTrue,
      );
    });
  });
}

class _InMemorySecureStore implements SecureKeyValueStore {
  final _data = <String, String>{};

  @override
  Future<void> write({required String key, required String value}) async {
    _data[key] = value;
  }

  @override
  Future<String?> read({required String key}) async {
    return _data[key];
  }

  @override
  Future<void> delete({required String key}) async {
    _data.remove(key);
  }
}

class _FakeBiometricAuthService implements BiometricAuthService {
  bool canCheck = true;
  bool supported = true;
  bool result = false;

  @override
  Future<bool> authenticate({required String localizedReason}) async {
    return result;
  }

  @override
  Future<bool> canCheckBiometrics() async {
    return canCheck;
  }

  @override
  Future<bool> isDeviceSupported() async {
    return supported;
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() async {
    if (canCheck) {
      return [BiometricType.fingerprint];
    }
    return [];
  }
}

class _FakeSettingsRepository implements SettingsRepository {
  final _controller = StreamController<Settings>.broadcast();
  Settings _settings = Settings.defaults();

  @override
  Future<Settings> fetchSettings() async {
    return _settings;
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    _settings = settings;
    _controller.add(settings);
  }

  @override
  Stream<Settings> watchSettings() {
    return _controller.stream;
  }
}
