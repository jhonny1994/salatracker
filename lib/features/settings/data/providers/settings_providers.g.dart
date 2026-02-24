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

@ProviderFor(notificationSchedulePlanner)
final notificationSchedulePlannerProvider =
    NotificationSchedulePlannerProvider._();

final class NotificationSchedulePlannerProvider
    extends
        $FunctionalProvider<
          NotificationSchedulePlanner,
          NotificationSchedulePlanner,
          NotificationSchedulePlanner
        >
    with $Provider<NotificationSchedulePlanner> {
  NotificationSchedulePlannerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSchedulePlannerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSchedulePlannerHash();

  @$internal
  @override
  $ProviderElement<NotificationSchedulePlanner> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationSchedulePlanner create(Ref ref) {
    return notificationSchedulePlanner(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationSchedulePlanner value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationSchedulePlanner>(value),
    );
  }
}

String _$notificationSchedulePlannerHash() =>
    r'a73f14ba301800ecfff3a2369e141185c56aaa07';

/// Provider for the app version string from platform metadata.

@ProviderFor(appVersion)
final appVersionProvider = AppVersionProvider._();

/// Provider for the app version string from platform metadata.

final class AppVersionProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// Provider for the app version string from platform metadata.
  AppVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return appVersion(ref);
  }
}

String _$appVersionHash() => r'2f6edf06a27184d1660212effe8a19ad6cc3838f';

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
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsNotifierHash();

  @$internal
  @override
  SettingsNotifier create() => SettingsNotifier();
}

String _$settingsNotifierHash() => r'7ff6c5bc9571048a667adc95c053289ffb97c18c';

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
