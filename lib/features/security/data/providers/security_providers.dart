import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/features/security/data/repositories/repositories.dart';
import 'package:salat_tracker/features/security/data/services/services.dart';
import 'package:salat_tracker/features/security/domain/domain.dart';
import 'package:salat_tracker/features/settings/data/providers/settings_providers.dart';

part 'security_providers.g.dart';

/// Provider for the secure storage instance.
@Riverpod(keepAlive: true)
FlutterSecureStorage flutterSecureStorage(Ref ref) {
  return const FlutterSecureStorage(
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
}

/// Provider for the local authentication instance.
@Riverpod(keepAlive: true)
LocalAuthentication localAuthentication(Ref ref) {
  return LocalAuthentication();
}

@Riverpod(keepAlive: true)
SecureKeyValueStore secureKeyValueStore(Ref ref) {
  return FlutterSecureKeyValueStore(ref.watch(flutterSecureStorageProvider));
}

@Riverpod(keepAlive: true)
BiometricAuthService biometricAuthService(Ref ref) {
  return LocalAuthBiometricService(ref.watch(localAuthenticationProvider));
}

/// Provider for the security repository.
@Riverpod(keepAlive: true)
SecurityRepository securityRepository(Ref ref) {
  return SecurityRepositoryImpl(
    secureStorage: ref.watch(secureKeyValueStoreProvider),
    biometricAuthService: ref.watch(biometricAuthServiceProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
  );
}

/// Provider that exposes whether biometrics are available on device.
@riverpod
Future<bool> biometricsAvailable(Ref ref) async {
  return ref.watch(securityRepositoryProvider).isBiometricsAvailable();
}

/// State of the app lock.
enum AppLockStatus {
  unlocked,
  locked,
}

/// Controller for managing the application lock state.
///
/// Starts unlocked on cold start. The `AppLockLifecycleGate` handles
/// locking the app when it resumes from background.
@Riverpod(keepAlive: true)
class AppLockController extends _$AppLockController {
  bool _suppressNextLock = false;
  DateTime? _lastUnlockTime;

  /// Visible for testing to mock system time for grace period checks.
  DateTime Function() clock = DateTime.now;

  @override
  Future<AppLockStatus> build() async {
    final settings = await ref.read(settingsProvider.future);
    if (!settings.onboardingComplete || !settings.appLockEnabled) {
      return AppLockStatus.unlocked;
    }

    final repository = ref.read(securityRepositoryProvider);
    final hasPin = await repository.hasPin();

    if (hasPin) {
      return AppLockStatus.locked;
    }

    return AppLockStatus.unlocked;
  }

  /// Prevents the next [lockApp] call from taking effect.
  ///
  /// Used by the lock screen before triggering biometric auth, because
  /// the system biometric dialog pauses the activity, which causes
  /// AppLockLifecycleGate to see a false resume event.
  void suppressNextLock() {
    _suppressNextLock = true;
  }

  /// Locks the application immediately.
  ///
  /// Ignores requests made within 2 seconds of the last unlock to prevent
  /// race conditions with system biometric dialog closing.
  void lockApp() {
    if (_suppressNextLock) {
      _suppressNextLock = false;
      return;
    }

    // Prevent immediate re-locking due to lifecycle events triggered by
    // the system biometric dialog closing.
    if (_lastUnlockTime != null) {
      final diff = clock().difference(_lastUnlockTime!);
      if (diff < const Duration(seconds: 2)) {
        return;
      }
    }

    state = const AsyncData(AppLockStatus.locked);
  }

  /// Unlocks the application.
  void unlockApp() {
    _suppressNextLock = false;
    _lastUnlockTime = clock();
    state = const AsyncData(AppLockStatus.unlocked);
  }
}
