import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Displays the current prayer streak count.
///
/// Hidden when streak is zero to avoid shame language.
class TodayStreakCard extends ConsumerWidget {
  /// Creates a [TodayStreakCard].
  const TodayStreakCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakCalculator = ref.watch(streakCalculatorProvider);
    final repository = ref.watch(prayerRepositoryProvider);
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return StreamBuilder<List<PrayerDay>>(
      stream: repository.watchDays(),
      builder: (context, snapshot) {
        final days = snapshot.data ?? [];
        final streak = streakCalculator.currentStreak(days);

        if (streak == 0) {
          return const SizedBox.shrink();
        }

        return Card(
              color: theme.colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.lg,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.local_fire_department_rounded,
                        color: theme.colorScheme.onPrimaryContainer,
                        size: AppIconSizes.lg,
                      ),
                    ),
                    const Gap(AppSpacing.md),
                    Expanded(
                      child: Text(
                        l10n.todayStreak(streak),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .animate()
            .fadeIn(duration: AppDurations.smooth)
            .scale(
              begin: const Offset(0.95, 0.95),
              end: const Offset(1, 1),
              duration: AppDurations.smooth,
              curve: Curves.easeOut,
            );
      },
    );
  }
}
