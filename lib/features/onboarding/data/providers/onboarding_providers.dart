import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/features/onboarding/onboarding.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';

part 'onboarding_providers.g.dart';

/// Manages the current step in the onboarding flow.
@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  OnboardingStep build() => OnboardingStep.welcome;

  /// Advances to the next step.
  void nextStep() {
    final currentIndex = OnboardingStep.values.indexOf(state);
    if (currentIndex < OnboardingStep.values.length - 1) {
      state = OnboardingStep.values[currentIndex + 1];
    }
  }

  /// Goes back to the previous step.
  void previousStep() {
    final currentIndex = OnboardingStep.values.indexOf(state);
    if (currentIndex > 0) {
      state = OnboardingStep.values[currentIndex - 1];
    }
  }

  /// Completes onboarding and marks it as done in settings.
  Future<void> completeOnboarding() async {
    await ref.read(settingsProvider.notifier).markOnboardingComplete();
  }
}

/// Tracks temporary prayer times during onboarding before confirmation.
@riverpod
class OnboardingPrayerTimes extends _$OnboardingPrayerTimes {
  @override
  Map<PrayerType, TimeOfDay> build() {
    // Start with defaults
    return Settings.defaults().prayerTimes;
  }

  /// Updates a specific prayer time.
  void updateTime(PrayerType type, TimeOfDay time) {
    state = Map.from(state)..[type] = time;
  }
}
