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
    r'e242177874f94487c4cc1a5643f3ed1f7826b9ce';

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
