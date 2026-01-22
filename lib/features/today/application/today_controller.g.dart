// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller managing today's prayer day state.
///
/// Provides the current day's prayer data and handles toggling prayer
/// completion with analytics tracking.

@ProviderFor(TodayController)
final todayControllerProvider = TodayControllerProvider._();

/// Controller managing today's prayer day state.
///
/// Provides the current day's prayer data and handles toggling prayer
/// completion with analytics tracking.
final class TodayControllerProvider
    extends $AsyncNotifierProvider<TodayController, PrayerDay> {
  /// Controller managing today's prayer day state.
  ///
  /// Provides the current day's prayer data and handles toggling prayer
  /// completion with analytics tracking.
  TodayControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayControllerHash();

  @$internal
  @override
  TodayController create() => TodayController();
}

String _$todayControllerHash() => r'420927de360cbb9219d49584fa37a2e5825c7922';

/// Controller managing today's prayer day state.
///
/// Provides the current day's prayer data and handles toggling prayer
/// completion with analytics tracking.

abstract class _$TodayController extends $AsyncNotifier<PrayerDay> {
  FutureOr<PrayerDay> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PrayerDay>, PrayerDay>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PrayerDay>, PrayerDay>,
              AsyncValue<PrayerDay>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
