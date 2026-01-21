// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TodayController)
final todayControllerProvider = TodayControllerProvider._();

final class TodayControllerProvider
    extends $AsyncNotifierProvider<TodayController, PrayerDay> {
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

String _$todayControllerHash() => r'c8ce5490f118020656085860f1eea35e7bf1149c';

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
