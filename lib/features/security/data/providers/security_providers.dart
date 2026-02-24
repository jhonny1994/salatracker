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
/// On cold start, checks whether app lock is enabled and a PIN exists.
/// If both conditions are met, the initial state is [AppLockStatus.locked],
/// which causes the router to redirect to the lock screen immediately.
@Riverpod(keepAlive: true)
class AppLockController extends _$AppLockController {
  @override
  Future<AppLockStatus> build() async {
    final repo = ref.read(securityRepositoryProvider);
    final isEnabled = await repo.isAppLockEnabled();
    final hasPin = await repo.hasPin();

    if (isEnabled && hasPin) {
      return AppLockStatus.locked;
    }
    return AppLockStatus.unlocked;
  }

  /// Locks the application immediately.
  void lockApp() {
    state = const AsyncData(AppLockStatus.locked);
  }

  /// Unlocks the application.
  void unlockApp() {
    state = const AsyncData(AppLockStatus.unlocked);
  }
}
