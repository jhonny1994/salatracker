import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/onboarding/onboarding.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Confirmation page - final step before completing onboarding.
class ConfirmationPage extends ConsumerStatefulWidget {
  /// Creates a [ConfirmationPage].
  const ConfirmationPage({
    required this.onComplete,
    required this.onBack,
    super.key,
  });

  /// Callback when user taps Get Started.
  final Future<void> Function() onComplete;

  /// Callback when user taps Back.
  final VoidCallback onBack;

  @override
  ConsumerState<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends ConsumerState<ConfirmationPage> {
  bool _submitting = false;

  Future<void> _submit() async {
    setState(() => _submitting = true);
    final l10n = S.of(context);

    try {
      final prayerTimes = ref.read(onboardingPrayerTimesProvider);
      final lateReminderTime = ref.read(onboardingLateReminderTimeProvider);

      await ref
          .read(settingsProvider.notifier)
          .applyOnboardingConfiguration(
            prayerTimes: prayerTimes,
            lateReminderTime: lateReminderTime,
          );
      await widget.onComplete();
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.errorLoadingSettings)));
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final prayerTimes = ref.watch(onboardingPrayerTimesProvider);
    final lateReminderTime = ref.watch(onboardingLateReminderTimeProvider);

    return OnboardingStepScaffold(
      icon: Icons.check_circle_outline,
      title: l10n.onboardingConfirmTitle,
      body: l10n.onboardingConfirmBody,
      primaryLabel: l10n.onboardingGetStarted,
      onPrimary: _submitting ? null : _submit,
      backLabel: l10n.onboardingBack,
      onBack: widget.onBack,
      isBusy: _submitting,
      busyLabel: l10n.generalLoading,
      content: AppSurfaceCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: ListView(
          children: [
            AppSectionHeader(title: l10n.settingsPrayerSchedule),
            const Divider(),
            ...PrayerType.values.map((type) {
              final time =
                  prayerTimes[type] ?? const TimeOfDay(hour: 0, minute: 0);
              return ListTile(
                dense: true,
                title: Text(_getPrayerName(type, l10n)),
                trailing: Text(time.format(context)),
              );
            }),
            const Divider(),
            AppSectionHeader(title: l10n.settingsDailyReminders),
            const Divider(),
            ListTile(
              dense: true,
              title: Text(l10n.onboardingLateReminderTitle),
              subtitle: Text(l10n.dailyReminderBody),
              trailing: Text(lateReminderTime.format(context)),
            ),
          ],
        ),
      ),
    );
  }

  String _getPrayerName(PrayerType type, S l10n) {
    return switch (type) {
      PrayerType.fajr => l10n.prayerFajr,
      PrayerType.dhuhr => l10n.prayerDhuhr,
      PrayerType.asr => l10n.prayerAsr,
      PrayerType.maghrib => l10n.prayerMaghrib,
      PrayerType.isha => l10n.prayerIsha,
    };
  }
}
