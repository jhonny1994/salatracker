// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Main router configuration.
///
/// Uses [GoRouter] for navigational state and deep-link handling.
/// Includes redirect guard for onboarding flow.

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// Main router configuration.
///
/// Uses [GoRouter] for navigational state and deep-link handling.
/// Includes redirect guard for onboarding flow.

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// Main router configuration.
  ///
  /// Uses [GoRouter] for navigational state and deep-link handling.
  /// Includes redirect guard for onboarding flow.
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'a240bde247fae3104053ecd3ac56ce8e7579db48';
