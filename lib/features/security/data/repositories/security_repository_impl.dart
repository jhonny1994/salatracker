import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:salat_tracker/features/security/data/services/services.dart';
import 'package:salat_tracker/features/security/domain/repositories/security_repository.dart';
import 'package:salat_tracker/features/settings/domain/repositories/settings_repository.dart';

/// Implementation of [SecurityRepository].
///
/// Uses a secure key-value store for PIN storage and biometric service
/// for biometric checks.
class SecurityRepositoryImpl implements SecurityRepository {
  /// Creates a [SecurityRepositoryImpl].
  SecurityRepositoryImpl({
    required SecureKeyValueStore secureStorage,
    required BiometricAuthService biometricAuthService,
    required SettingsRepository settingsRepository,
    DateTime Function()? now,
  }) : _secureStorage = secureStorage,
       _biometricAuthService = biometricAuthService,
       _settingsRepository = settingsRepository,
       _now = now ?? DateTime.now;

  final SecureKeyValueStore _secureStorage;
  final BiometricAuthService _biometricAuthService;
  final SettingsRepository _settingsRepository;
  final DateTime Function() _now;

  static const _pinHashKey = 'pin_hash_v1';
  static const _pinSaltKey = 'pin_salt_v1';
  static const _legacyPinKey = 'user_pin';
  static const _failedAttemptsKey = 'pin_failed_attempts_v1';
  static const _lockoutUntilMsKey = 'pin_lockout_until_ms_v1';
  static const _maxFailedAttempts = 5;
  static const _lockoutDuration = Duration(minutes: 2);
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
    final remaining = await lockoutRemaining();
    if (remaining != null) {
      return false;
    }

    final salt = await _secureStorage.read(key: _pinSaltKey);
    final hash = await _secureStorage.read(key: _pinHashKey);
    bool valid;

    if (salt != null && hash != null) {
      valid = _hashPin(pin: pin, salt: salt) == hash;
    } else {
      // Legacy plaintext fallback with migration.
      final legacyPin = await _secureStorage.read(key: _legacyPinKey);
      valid = legacyPin == pin;
      if (valid) {
        await setPin(pin);
      }
    }

    if (valid) {
      await _clearAttemptState();
      return true;
    }

    await _registerFailedAttempt();
    return valid;
  }

  @override
  Future<Duration?> lockoutRemaining() async {
    final nowMs = _now().millisecondsSinceEpoch;
    final raw = await _secureStorage.read(key: _lockoutUntilMsKey);
    final untilMs = int.tryParse(raw ?? '');

    if (untilMs == null || untilMs <= nowMs) {
      await _secureStorage.delete(key: _lockoutUntilMsKey);
      return null;
    }

    return Duration(milliseconds: untilMs - nowMs);
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
    await _clearAttemptState();
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

      return await _biometricAuthService.authenticate(
        localizedReason: reason,
      );
    } on Exception catch (_) {
      // Log error to Sentry if needed
      return false;
    }
  }

  @override
  Future<bool> isBiometricsAvailable() async {
    try {
      final canCheck = await _biometricAuthService.canCheckBiometrics();
      final isDeviceSupported = await _biometricAuthService.isDeviceSupported();
      if (!canCheck || !isDeviceSupported) return false;

      final enrolled = await _biometricAuthService.getAvailableBiometrics();
      return enrolled.isNotEmpty;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<bool> isBiometricUnlockEnabled() async {
    final settings = await _settingsRepository.fetchSettings();
    return settings.biometricUnlockEnabled;
  }

  String _generateSalt() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    return base64UrlEncode(bytes);
  }

  String _hashPin({required String pin, required String salt}) {
    return sha256.convert(utf8.encode('$salt:$pin')).toString();
  }

  Future<void> _registerFailedAttempt() async {
    final currentRaw = await _secureStorage.read(key: _failedAttemptsKey);
    final current = int.tryParse(currentRaw ?? '') ?? 0;
    final next = current + 1;

    if (next >= _maxFailedAttempts) {
      final untilDate = _now().add(_lockoutDuration);
      final until = untilDate.millisecondsSinceEpoch.toString();
      await _secureStorage.write(key: _lockoutUntilMsKey, value: until);
      await _secureStorage.write(key: _failedAttemptsKey, value: '0');
      return;
    }

    await _secureStorage.write(key: _failedAttemptsKey, value: '$next');
  }

  Future<void> _clearAttemptState() async {
    await _secureStorage.delete(key: _failedAttemptsKey);
    await _secureStorage.delete(key: _lockoutUntilMsKey);
  }
}
