// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the settings local data source.

@ProviderFor(settingsLocalDataSource)
final settingsLocalDataSourceProvider = SettingsLocalDataSourceProvider._();

/// Provider for the settings local data source.

final class SettingsLocalDataSourceProvider
    extends
        $FunctionalProvider<
          SettingsLocalDataSource,
          SettingsLocalDataSource,
          SettingsLocalDataSource
        >
    with $Provider<SettingsLocalDataSource> {
  /// Provider for the settings local data source.
  SettingsLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<SettingsLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingsLocalDataSource create(Ref ref) {
    return settingsLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsLocalDataSource>(value),
    );
  }
}

String _$settingsLocalDataSourceHash() =>
    r'81668d918d896f152b7ab486945bc4bddc92148d';

/// Provider for the settings repository.

@ProviderFor(settingsRepository)
final settingsRepositoryProvider = SettingsRepositoryProvider._();

/// Provider for the settings repository.

final class SettingsRepositoryProvider
    extends
        $FunctionalProvider<
          SettingsRepository,
          SettingsRepository,
          SettingsRepository
        >
    with $Provider<SettingsRepository> {
  /// Provider for the settings repository.
  SettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingsRepository create(Ref ref) {
    return settingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsRepository>(value),
    );
  }
}

String _$settingsRepositoryHash() =>
    r'f6c934ff287aa202ca3f6df8569d18e30ca6c102';

/// Notifier managing application settings state.
///
/// Provides methods to update theme, language, notifications, and other
/// user preferences with persistence.

@ProviderFor(SettingsNotifier)
final settingsProvider = SettingsNotifierProvider._();

/// Notifier managing application settings state.
///
/// Provides methods to update theme, language, notifications, and other
/// user preferences with persistence.
final class SettingsNotifierProvider
    extends $AsyncNotifierProvider<SettingsNotifier, Settings> {
  /// Notifier managing application settings state.
  ///
  /// Provides methods to update theme, language, notifications, and other
  /// user preferences with persistence.
  SettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsNotifierHash();

  @$internal
  @override
  SettingsNotifier create() => SettingsNotifier();
}

String _$settingsNotifierHash() => r'30792551a52043c6d7fcdd6ec4c9280315f37f64';

/// Notifier managing application settings state.
///
/// Provides methods to update theme, language, notifications, and other
/// user preferences with persistence.

abstract class _$SettingsNotifier extends $AsyncNotifier<Settings> {
  FutureOr<Settings> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Settings>, Settings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Settings>, Settings>,
              AsyncValue<Settings>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
