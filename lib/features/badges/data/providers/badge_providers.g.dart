// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(badgeLocalDataSource)
final badgeLocalDataSourceProvider = BadgeLocalDataSourceProvider._();

final class BadgeLocalDataSourceProvider
    extends
        $FunctionalProvider<
          BadgeLocalDataSource,
          BadgeLocalDataSource,
          BadgeLocalDataSource
        >
    with $Provider<BadgeLocalDataSource> {
  BadgeLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'badgeLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$badgeLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<BadgeLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BadgeLocalDataSource create(Ref ref) {
    return badgeLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BadgeLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BadgeLocalDataSource>(value),
    );
  }
}

String _$badgeLocalDataSourceHash() =>
    r'391ee0f3232852554b6243122d4e25faa601d63f';

@ProviderFor(badgeRepository)
final badgeRepositoryProvider = BadgeRepositoryProvider._();

final class BadgeRepositoryProvider
    extends
        $FunctionalProvider<BadgeRepository, BadgeRepository, BadgeRepository>
    with $Provider<BadgeRepository> {
  BadgeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'badgeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$badgeRepositoryHash();

  @$internal
  @override
  $ProviderElement<BadgeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BadgeRepository create(Ref ref) {
    return badgeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BadgeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BadgeRepository>(value),
    );
  }
}

String _$badgeRepositoryHash() => r'4fd2aad788e6083e8a234407164e7427da002973';

@ProviderFor(badgeEvaluator)
final badgeEvaluatorProvider = BadgeEvaluatorProvider._();

final class BadgeEvaluatorProvider
    extends $FunctionalProvider<BadgeEvaluator, BadgeEvaluator, BadgeEvaluator>
    with $Provider<BadgeEvaluator> {
  BadgeEvaluatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'badgeEvaluatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$badgeEvaluatorHash();

  @$internal
  @override
  $ProviderElement<BadgeEvaluator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BadgeEvaluator create(Ref ref) {
    return badgeEvaluator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BadgeEvaluator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BadgeEvaluator>(value),
    );
  }
}

String _$badgeEvaluatorHash() => r'dd48bf287bc5ddad77412cd98672d4036a03dea5';

@ProviderFor(badges)
final badgesProvider = BadgesProvider._();

final class BadgesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BadgeAward>>,
          List<BadgeAward>,
          Stream<List<BadgeAward>>
        >
    with $FutureModifier<List<BadgeAward>>, $StreamProvider<List<BadgeAward>> {
  BadgesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'badgesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$badgesHash();

  @$internal
  @override
  $StreamProviderElement<List<BadgeAward>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<BadgeAward>> create(Ref ref) {
    return badges(ref);
  }
}

String _$badgesHash() => r'258b7e8fb608e5ae5fbc4506396b6b6fa673ea02';
