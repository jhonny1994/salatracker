// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the platform-specific analytics implementation.
///
/// In debug mode, this returns [SentryAnalyticsService].
/// In release mode, this could return Firebase/PostHog/etc.

@ProviderFor(analytics)
final analyticsProvider = AnalyticsProvider._();

/// Provides the platform-specific analytics implementation.
///
/// In debug mode, this returns [SentryAnalyticsService].
/// In release mode, this could return Firebase/PostHog/etc.

final class AnalyticsProvider
    extends
        $FunctionalProvider<
          AnalyticsService,
          AnalyticsService,
          AnalyticsService
        >
    with $Provider<AnalyticsService> {
  /// Provides the platform-specific analytics implementation.
  ///
  /// In debug mode, this returns [SentryAnalyticsService].
  /// In release mode, this could return Firebase/PostHog/etc.
  AnalyticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsHash();

  @$internal
  @override
  $ProviderElement<AnalyticsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AnalyticsService create(Ref ref) {
    return analytics(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsService>(value),
    );
  }
}

String _$analyticsHash() => r'1e87c1f04c9eb8247daabf3c2a2b51c510682434';
