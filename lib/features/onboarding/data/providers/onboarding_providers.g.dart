// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Manages the current step in the onboarding flow.

@ProviderFor(OnboardingController)
final onboardingControllerProvider = OnboardingControllerProvider._();

/// Manages the current step in the onboarding flow.
final class OnboardingControllerProvider
    extends $NotifierProvider<OnboardingController, OnboardingStep> {
  /// Manages the current step in the onboarding flow.
  OnboardingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingControllerHash();

  @$internal
  @override
  OnboardingController create() => OnboardingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingStep value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingStep>(value),
    );
  }
}

String _$onboardingControllerHash() =>
    r'1a8eeee4d2519e1f3726dd6c96e911f4b63f5c3f';

/// Manages the current step in the onboarding flow.

abstract class _$OnboardingController extends $Notifier<OnboardingStep> {
  OnboardingStep build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<OnboardingStep, OnboardingStep>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OnboardingStep, OnboardingStep>,
              OnboardingStep,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Tracks temporary prayer times during onboarding before confirmation.

@ProviderFor(OnboardingPrayerTimes)
final onboardingPrayerTimesProvider = OnboardingPrayerTimesProvider._();

/// Tracks temporary prayer times during onboarding before confirmation.
final class OnboardingPrayerTimesProvider
    extends
        $NotifierProvider<OnboardingPrayerTimes, Map<PrayerType, TimeOfDay>> {
  /// Tracks temporary prayer times during onboarding before confirmation.
  OnboardingPrayerTimesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingPrayerTimesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingPrayerTimesHash();

  @$internal
  @override
  OnboardingPrayerTimes create() => OnboardingPrayerTimes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<PrayerType, TimeOfDay> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<PrayerType, TimeOfDay>>(value),
    );
  }
}

String _$onboardingPrayerTimesHash() =>
    r'693f2adb39a485ac674a282a951d728cea87fc41';

/// Tracks temporary prayer times during onboarding before confirmation.

abstract class _$OnboardingPrayerTimes
    extends $Notifier<Map<PrayerType, TimeOfDay>> {
  Map<PrayerType, TimeOfDay> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<Map<PrayerType, TimeOfDay>, Map<PrayerType, TimeOfDay>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<PrayerType, TimeOfDay>,
                Map<PrayerType, TimeOfDay>
              >,
              Map<PrayerType, TimeOfDay>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
