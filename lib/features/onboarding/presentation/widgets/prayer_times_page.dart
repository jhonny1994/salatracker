import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/onboarding/data/providers/onboarding_providers.dart';
import 'package:salat_tracker/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';
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
    final times = ref.watch(onboardingPrayerTimesProvider);
    return OnboardingStepScaffold(
      icon: Icons.access_time_outlined,
      title: l10n.onboardingPrayerTimesTitle,
      body: l10n.onboardingPrayerTimesBody,
      primaryLabel: l10n.onboardingNext,
      onPrimary: onNext,
      backLabel: l10n.onboardingBack,
      onBack: onBack,
      content: AppSurfaceCard(
        padding: EdgeInsets.zero,
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
