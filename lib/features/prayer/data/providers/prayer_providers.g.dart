// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(prayerLocalDataSource)
final prayerLocalDataSourceProvider = PrayerLocalDataSourceProvider._();

final class PrayerLocalDataSourceProvider
    extends
        $FunctionalProvider<
          PrayerLocalDataSource,
          PrayerLocalDataSource,
          PrayerLocalDataSource
        >
    with $Provider<PrayerLocalDataSource> {
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

@ProviderFor(prayerRepository)
final prayerRepositoryProvider = PrayerRepositoryProvider._();

final class PrayerRepositoryProvider
    extends
        $FunctionalProvider<
          PrayerRepository,
          PrayerRepository,
          PrayerRepository
        >
    with $Provider<PrayerRepository> {
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

@ProviderFor(streakCalculator)
final streakCalculatorProvider = StreakCalculatorProvider._();

final class StreakCalculatorProvider
    extends
        $FunctionalProvider<
          StreakCalculator,
          StreakCalculator,
          StreakCalculator
        >
    with $Provider<StreakCalculator> {
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

@ProviderFor(pointsCalculator)
final pointsCalculatorProvider = PointsCalculatorProvider._();

final class PointsCalculatorProvider
    extends
        $FunctionalProvider<
          PointsCalculator,
          PointsCalculator,
          PointsCalculator
        >
    with $Provider<PointsCalculator> {
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
