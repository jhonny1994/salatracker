// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the secure storage instance.

@ProviderFor(flutterSecureStorage)
final flutterSecureStorageProvider = FlutterSecureStorageProvider._();

/// Provider for the secure storage instance.

final class FlutterSecureStorageProvider
    extends
        $FunctionalProvider<
          FlutterSecureStorage,
          FlutterSecureStorage,
          FlutterSecureStorage
        >
    with $Provider<FlutterSecureStorage> {
  /// Provider for the secure storage instance.
  FlutterSecureStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flutterSecureStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flutterSecureStorageHash();

  @$internal
  @override
  $ProviderElement<FlutterSecureStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlutterSecureStorage create(Ref ref) {
    return flutterSecureStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlutterSecureStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlutterSecureStorage>(value),
    );
  }
}

String _$flutterSecureStorageHash() =>
    r'40a8943c6e6a6bec17d2aaaa929cdb73a80eaf35';

/// Provider for the local authentication instance.

@ProviderFor(localAuthentication)
final localAuthenticationProvider = LocalAuthenticationProvider._();

/// Provider for the local authentication instance.

final class LocalAuthenticationProvider
    extends
        $FunctionalProvider<
          LocalAuthentication,
          LocalAuthentication,
          LocalAuthentication
        >
    with $Provider<LocalAuthentication> {
  /// Provider for the local authentication instance.
  LocalAuthenticationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localAuthenticationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localAuthenticationHash();

  @$internal
  @override
  $ProviderElement<LocalAuthentication> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalAuthentication create(Ref ref) {
    return localAuthentication(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalAuthentication value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalAuthentication>(value),
    );
  }
}

String _$localAuthenticationHash() =>
    r'd0bd2cc313c3ef614f8cb486f8d8413b2f57d9a9';

@ProviderFor(secureKeyValueStore)
final secureKeyValueStoreProvider = SecureKeyValueStoreProvider._();

final class SecureKeyValueStoreProvider
    extends
        $FunctionalProvider<
          SecureKeyValueStore,
          SecureKeyValueStore,
          SecureKeyValueStore
        >
    with $Provider<SecureKeyValueStore> {
  SecureKeyValueStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureKeyValueStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureKeyValueStoreHash();

  @$internal
  @override
  $ProviderElement<SecureKeyValueStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SecureKeyValueStore create(Ref ref) {
    return secureKeyValueStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecureKeyValueStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecureKeyValueStore>(value),
    );
  }
}

String _$secureKeyValueStoreHash() =>
    r'b5f118bc83b61e1011df5036b63e9b658b4fe3de';

@ProviderFor(biometricAuthService)
final biometricAuthServiceProvider = BiometricAuthServiceProvider._();

final class BiometricAuthServiceProvider
    extends
        $FunctionalProvider<
          BiometricAuthService,
          BiometricAuthService,
          BiometricAuthService
        >
    with $Provider<BiometricAuthService> {
  BiometricAuthServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricAuthServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricAuthServiceHash();

  @$internal
  @override
  $ProviderElement<BiometricAuthService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BiometricAuthService create(Ref ref) {
    return biometricAuthService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BiometricAuthService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BiometricAuthService>(value),
    );
  }
}

String _$biometricAuthServiceHash() =>
    r'e2502eb1a3e45e86b867095e251e01140505fc2e';

/// Provider for the security repository.

@ProviderFor(securityRepository)
final securityRepositoryProvider = SecurityRepositoryProvider._();

/// Provider for the security repository.

final class SecurityRepositoryProvider
    extends
        $FunctionalProvider<
          SecurityRepository,
          SecurityRepository,
          SecurityRepository
        >
    with $Provider<SecurityRepository> {
  /// Provider for the security repository.
  SecurityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'securityRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$securityRepositoryHash();

  @$internal
  @override
  $ProviderElement<SecurityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SecurityRepository create(Ref ref) {
    return securityRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecurityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecurityRepository>(value),
    );
  }
}

String _$securityRepositoryHash() =>
    r'8fa278de49cec559362be96056c87ee4bf8fd349';

/// Provider that exposes whether biometrics are available on device.

@ProviderFor(biometricsAvailable)
final biometricsAvailableProvider = BiometricsAvailableProvider._();

/// Provider that exposes whether biometrics are available on device.

final class BiometricsAvailableProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Provider that exposes whether biometrics are available on device.
  BiometricsAvailableProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricsAvailableProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricsAvailableHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return biometricsAvailable(ref);
  }
}

String _$biometricsAvailableHash() =>
    r'f8b8b186bf16d811f6617711ca99977e9994d155';

/// Controller for managing the application lock state.

@ProviderFor(AppLockController)
final appLockControllerProvider = AppLockControllerProvider._();

/// Controller for managing the application lock state.
final class AppLockControllerProvider
    extends $NotifierProvider<AppLockController, AppLockStatus> {
  /// Controller for managing the application lock state.
  AppLockControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLockControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLockControllerHash();

  @$internal
  @override
  AppLockController create() => AppLockController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLockStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLockStatus>(value),
    );
  }
}

String _$appLockControllerHash() => r'fce10201e317dcb876689156794b0cf7522cb321';

/// Controller for managing the application lock state.

abstract class _$AppLockController extends $Notifier<AppLockStatus> {
  AppLockStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppLockStatus, AppLockStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppLockStatus, AppLockStatus>,
              AppLockStatus,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
