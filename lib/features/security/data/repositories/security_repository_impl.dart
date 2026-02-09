import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:salat_tracker/features/security/domain/repositories/security_repository.dart';
import 'package:salat_tracker/features/settings/domain/repositories/settings_repository.dart';

/// Implementation of [SecurityRepository].
///
/// Uses [FlutterSecureStorage] for secure PIN storage and [LocalAuthentication]
/// for biometric checks.
class SecurityRepositoryImpl implements SecurityRepository {
  /// Creates a [SecurityRepositoryImpl].
  SecurityRepositoryImpl({
    required FlutterSecureStorage secureStorage,
    required LocalAuthentication localAuth,
    required SettingsRepository settingsRepository,
  }) : _secureStorage = secureStorage,
       _localAuth = localAuth,
       _settingsRepository = settingsRepository;

  final FlutterSecureStorage _secureStorage;
  final LocalAuthentication _localAuth;
  final SettingsRepository _settingsRepository;

  static const _pinHashKey = 'pin_hash_v1';
  static const _pinSaltKey = 'pin_salt_v1';
  static const _legacyPinKey = 'user_pin';
  final _random = Random.secure();

  @override
  Future<void> setPin(String pin) async {
    final salt = _generateSalt();
    final hash = _hashPin(pin: pin, salt: salt);
    await _secureStorage.write(key: _pinSaltKey, value: salt);
    await _secureStorage.write(key: _pinHashKey, value: hash);
    // Best-effort cleanup of old plaintext storage.
    await _secureStorage.delete(key: _legacyPinKey);
  }

  @override
  Future<bool> verifyPin(String pin) async {
    final salt = await _secureStorage.read(key: _pinSaltKey);
    final hash = await _secureStorage.read(key: _pinHashKey);
    if (salt != null && hash != null) {
      return _hashPin(pin: pin, salt: salt) == hash;
    }

    // Legacy plaintext fallback with migration.
    final legacyPin = await _secureStorage.read(key: _legacyPinKey);
    final valid = legacyPin == pin;
    if (valid) {
      await setPin(pin);
    }
    return valid;
  }

  @override
  Future<bool> hasPin() async {
    final hash = await _secureStorage.read(key: _pinHashKey);
    if (hash != null && hash.isNotEmpty) {
      return true;
    }

    final legacyPin = await _secureStorage.read(key: _legacyPinKey);
    return legacyPin != null && legacyPin.isNotEmpty;
  }

  @override
  Future<void> removePin() async {
    await _secureStorage.delete(key: _pinHashKey);
    await _secureStorage.delete(key: _pinSaltKey);
    await _secureStorage.delete(key: _legacyPinKey);
  }

  @override
  Future<bool> isAppLockEnabled() async {
    final settings = await _settingsRepository.fetchSettings();
    return settings.appLockEnabled;
  }

  @override
  Future<void> setAppLockEnabled({required bool enabled}) async {
    final settings = await _settingsRepository.fetchSettings();
    await _settingsRepository.saveSettings(
      settings.copyWith(appLockEnabled: enabled),
    );
  }

  @override
  Future<bool> authenticateWithBiometrics({required String reason}) async {
    try {
      final isAvailable = await isBiometricsAvailable();
      if (!isAvailable) return false;

      return await _localAuth.authenticate(
        localizedReason: reason,
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
    } on Exception catch (_) {
      // Log error to Sentry if needed
      return false;
    }
  }

  @override
  Future<bool> isBiometricsAvailable() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheck && isDeviceSupported;
    } on Exception catch (_) {
      return false;
    }
  }

  String _generateSalt() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    return base64UrlEncode(bytes);
  }

  String _hashPin({required String pin, required String salt}) {
    return sha256.convert(utf8.encode('$salt:$pin')).toString();
  }
}
