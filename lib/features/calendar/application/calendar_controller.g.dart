// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(calendarDays)
final calendarDaysProvider = CalendarDaysProvider._();

final class CalendarDaysProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<DateTime, PrayerDay>>,
          Map<DateTime, PrayerDay>,
          Stream<Map<DateTime, PrayerDay>>
        >
    with
        $FutureModifier<Map<DateTime, PrayerDay>>,
        $StreamProvider<Map<DateTime, PrayerDay>> {
  CalendarDaysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarDaysProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarDaysHash();

  @$internal
  @override
  $StreamProviderElement<Map<DateTime, PrayerDay>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<DateTime, PrayerDay>> create(Ref ref) {
    return calendarDays(ref);
  }
}

String _$calendarDaysHash() => r'b9a4164059c84f7e5e094accb2e1c896b23657e7';

@ProviderFor(SelectedDayController)
final selectedDayControllerProvider = SelectedDayControllerProvider._();

final class SelectedDayControllerProvider
    extends $NotifierProvider<SelectedDayController, DateTime> {
  SelectedDayControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedDayControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedDayControllerHash();

  @$internal
  @override
  SelectedDayController create() => SelectedDayController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$selectedDayControllerHash() =>
    r'5f76e3f3cc7b35bb58693d1d590866ef94e7269e';

abstract class _$SelectedDayController extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
