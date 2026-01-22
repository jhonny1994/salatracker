// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the prayer local data source.

@ProviderFor(prayerLocalDataSource)
final prayerLocalDataSourceProvider = PrayerLocalDataSourceProvider._();

/// Provider for the prayer local data source.

final class PrayerLocalDataSourceProvider
    extends
        $FunctionalProvider<
          PrayerLocalDataSource,
          PrayerLocalDataSource,
          PrayerLocalDataSource
        >
    with $Provider<PrayerLocalDataSource> {
  /// Provider for the prayer local data source.
  PrayerLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prayerLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prayerLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<PrayerLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PrayerLocalDataSource create(Ref ref) {
    return prayerLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrayerLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrayerLocalDataSource>(value),
    );
  }
}

String _$prayerLocalDataSourceHash() =>
    r'7850bf43c221a37efe5f004857a82ddd00badbbf';

/// Provider for the prayer repository.

@ProviderFor(prayerRepository)
final prayerRepositoryProvider = PrayerRepositoryProvider._();

/// Provider for the prayer repository.

final class PrayerRepositoryProvider
    extends
        $FunctionalProvider<
          PrayerRepository,
          PrayerRepository,
          PrayerRepository
        >
    with $Provider<PrayerRepository> {
  /// Provider for the prayer repository.
  PrayerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prayerRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prayerRepositoryHash();

  @$internal
  @override
  $ProviderElement<PrayerRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PrayerRepository create(Ref ref) {
    return prayerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrayerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrayerRepository>(value),
    );
  }
}

String _$prayerRepositoryHash() => r'5812eea29c880da200393f05696f907f2e846861';

/// Provider for the streak calculator service.

@ProviderFor(streakCalculator)
final streakCalculatorProvider = StreakCalculatorProvider._();

/// Provider for the streak calculator service.

final class StreakCalculatorProvider
    extends
        $FunctionalProvider<
          StreakCalculator,
          StreakCalculator,
          StreakCalculator
        >
    with $Provider<StreakCalculator> {
  /// Provider for the streak calculator service.
  StreakCalculatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'streakCalculatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$streakCalculatorHash();

  @$internal
  @override
  $ProviderElement<StreakCalculator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StreakCalculator create(Ref ref) {
    return streakCalculator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StreakCalculator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StreakCalculator>(value),
    );
  }
}

String _$streakCalculatorHash() => r'e1892636678b7c65ba9dedf916cfa1feb4c08fd1';

/// Provider for the points calculator service.

@ProviderFor(pointsCalculator)
final pointsCalculatorProvider = PointsCalculatorProvider._();

/// Provider for the points calculator service.

final class PointsCalculatorProvider
    extends
        $FunctionalProvider<
          PointsCalculator,
          PointsCalculator,
          PointsCalculator
        >
    with $Provider<PointsCalculator> {
  /// Provider for the points calculator service.
  PointsCalculatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pointsCalculatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pointsCalculatorHash();

  @$internal
  @override
  $ProviderElement<PointsCalculator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PointsCalculator create(Ref ref) {
    return pointsCalculator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PointsCalculator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PointsCalculator>(value),
    );
  }
}

String _$pointsCalculatorHash() => r'9f7bf33f0f4111a986d581fcef2a2b313957818c';
