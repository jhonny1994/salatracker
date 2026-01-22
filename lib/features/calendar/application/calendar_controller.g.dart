// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider exposing a reactive map of prayer days keyed by date.
///
/// Transforms the prayer days list into a map for efficient date lookups
/// in calendar rendering.

@ProviderFor(calendarDays)
final calendarDaysProvider = CalendarDaysProvider._();

/// Provider exposing a reactive map of prayer days keyed by date.
///
/// Transforms the prayer days list into a map for efficient date lookups
/// in calendar rendering.

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
  /// Provider exposing a reactive map of prayer days keyed by date.
  ///
  /// Transforms the prayer days list into a map for efficient date lookups
  /// in calendar rendering.
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

/// Controller managing the currently selected day in the calendar.
///
/// Tracks which day the user has selected for detailed viewing and logs
/// analytics events for history navigation.

@ProviderFor(SelectedDayController)
final selectedDayControllerProvider = SelectedDayControllerProvider._();

/// Controller managing the currently selected day in the calendar.
///
/// Tracks which day the user has selected for detailed viewing and logs
/// analytics events for history navigation.
final class SelectedDayControllerProvider
    extends $NotifierProvider<SelectedDayController, DateTime> {
  /// Controller managing the currently selected day in the calendar.
  ///
  /// Tracks which day the user has selected for detailed viewing and logs
  /// analytics events for history navigation.
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
    r'948ce047286fbd3fd714e3d5439f15bb816f2b37';

/// Controller managing the currently selected day in the calendar.
///
/// Tracks which day the user has selected for detailed viewing and logs
/// analytics events for history navigation.

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
