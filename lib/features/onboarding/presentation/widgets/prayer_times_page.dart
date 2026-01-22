import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/onboarding/data/providers/onboarding_providers.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Prayer times setup page.
class PrayerTimesPage extends ConsumerWidget {
  /// Creates a [PrayerTimesPage].
  const PrayerTimesPage({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  /// Callback when user taps Next.
  final VoidCallback onNext;

  /// Callback when user taps Back.
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final times = ref.watch(onboardingPrayerTimesProvider);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Text(
            l10n.onboardingPrayerTimesTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(AppSpacing.sm),

          // Body
          Text(
            l10n.onboardingPrayerTimesBody,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(AppSpacing.xl),

          // Prayer time list
          Expanded(
            child: ListView(
              children: PrayerType.values.map((type) {
                final time = times[type] ?? const TimeOfDay(hour: 0, minute: 0);
                return ListTile(
                  title: Text(_getPrayerName(type, l10n)),
                  trailing: TextButton(
                    onPressed: () => _pickTime(context, ref, type, time),
                    child: Text(time.format(context)),
                  ),
                );
              }).toList(),
            ),
          ),

          // Navigation buttons
          Row(
            children: [
              TextButton(
                onPressed: onBack,
                child: Text(l10n.onboardingBack),
              ),
              const Spacer(),
              FilledButton(
                onPressed: onNext,
                child: Text(l10n.onboardingNext),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime(
    BuildContext context,
    WidgetRef ref,
    PrayerType type,
    TimeOfDay current,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: current,
    );
    if (picked != null) {
      ref.read(onboardingPrayerTimesProvider.notifier).updateTime(type, picked);
    }
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
