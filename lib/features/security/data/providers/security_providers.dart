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
@Riverpod(keepAlive: true)
class AppLockController extends _$AppLockController {
  @override
  AppLockStatus build() {
    return AppLockStatus
        .unlocked; // Default to unlocked initially to avoid blocking startup
  }

  /// Locks the application immediately.
  void lockApp() {
    state = AppLockStatus.locked;
  }

  /// Unlocks the application.
  void unlockApp() {
    state = AppLockStatus.unlocked;
  }
}
