import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/onboarding/data/providers/onboarding_providers.dart';
import 'package:salat_tracker/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Confirmation page - final step before completing onboarding.
class ConfirmationPage extends ConsumerWidget {
  /// Creates a [ConfirmationPage].
  const ConfirmationPage({
    required this.onComplete,
    required this.onBack,
    super.key,
  });

  /// Callback when user taps Get Started.
  final VoidCallback onComplete;

  /// Callback when user taps Back.
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final prayerTimes = ref.watch(onboardingPrayerTimesProvider);
    return OnboardingStepScaffold(
      icon: Icons.check_circle_outline,
      title: l10n.onboardingConfirmTitle,
      body: l10n.onboardingConfirmBody,
      primaryLabel: l10n.onboardingGetStarted,
      onPrimary: () async {
        for (final entry in prayerTimes.entries) {
          await ref
              .read(settingsProvider.notifier)
              .updatePrayerTime(
                type: entry.key,
                time: entry.value,
              );
        }
        onComplete();
      },
      backLabel: l10n.onboardingBack,
      onBack: onBack,
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
