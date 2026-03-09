import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/features/onboarding/onboarding.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';

part 'onboarding_providers.g.dart';

/// Manages the current step in the onboarding flow.
@Riverpod(keepAlive: true)
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

  /// Sets the active step by index.
  void setStepByIndex(int index) {
    if (index < 0 || index >= OnboardingStep.values.length) {
      return;
    }
    state = OnboardingStep.values[index];
  }

  /// Completes onboarding and marks it as done in settings.
  Future<void> completeOnboarding() async {
    await ref.read(settingsProvider.notifier).markOnboardingComplete();
  }
}

/// Tracks temporary prayer times during onboarding before confirmation.
@Riverpod(keepAlive: true)
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

/// Tracks the suggested late reminder time during onboarding.
@Riverpod(keepAlive: true)
class OnboardingLateReminderTime extends _$OnboardingLateReminderTime {
  bool _wasManuallyEdited = false;

  @override
  TimeOfDay build() => Settings.defaults().effectiveDailyReminders.first.time;

  void syncSuggestedFromPrayerTimes(Map<PrayerType, TimeOfDay> prayerTimes) {
    if (_wasManuallyEdited) {
      return;
    }

    final isha =
        prayerTimes[PrayerType.isha] ?? const TimeOfDay(hour: 20, minute: 30);
    final totalMinutes = ((isha.hour * 60) + isha.minute + 120) % (24 * 60);
    state = TimeOfDay(
      hour: totalMinutes ~/ 60,
      minute: totalMinutes % 60,
    );
  }

  void updateTime(TimeOfDay time) {
    _wasManuallyEdited = true;
    state = time;
  }
}
