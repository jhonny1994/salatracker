import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/onboarding/data/providers/onboarding_providers.dart';
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
    final theme = Theme.of(context);
    final prayerTimes = ref.watch(onboardingPrayerTimesProvider);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Text(
            l10n.onboardingConfirmTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(AppSpacing.sm),

          // Body
          Text(
            l10n.onboardingConfirmBody,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(AppSpacing.xl),

          // Summary card
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: ListView(
                  children: [
                    Text(
                      l10n.settingsPrayerSchedule,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    ...PrayerType.values.map((type) {
                      final time =
                          prayerTimes[type] ??
                          const TimeOfDay(hour: 0, minute: 0);
                      return ListTile(
                        dense: true,
                        title: Text(_getPrayerName(type, l10n)),
                        trailing: Text(
                          time.format(context),
                          style: theme.textTheme.bodyMedium,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          const Gap(AppSpacing.lg),

          // Get Started button
          FilledButton(
            onPressed: () async {
              // Save prayer times to settings
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
            child: Text(l10n.onboardingGetStarted),
          ),
          const Gap(AppSpacing.sm),

          // Back button
          TextButton(
            onPressed: onBack,
            child: Text(l10n.onboardingBack),
          ),
        ],
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
