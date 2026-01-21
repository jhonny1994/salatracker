import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

class TodayProgressCard extends StatelessWidget {
  const TodayProgressCard({
    required this.completedCount,
    required this.totalPrayers,
    required this.completionPercentage,
    required this.points,
    super.key,
  });

  final int completedCount;
  final int totalPrayers;
  final double completionPercentage;
  final int points;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final statusMessage = switch (completedCount) {
      0 => l10n.todayNone,
      5 => l10n.todayComplete,
      _ => l10n.todayPartial(completedCount),
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.todayProgress,
              style: theme.textTheme.titleMedium,
            ),
            const Gap(AppSpacing.xl),
            // Beautiful circular progress indicator
            Center(
              child: RepaintBoundary(
                child: CircularPercentIndicator(
                  radius: 80,
                  lineWidth: 12,
                  percent: completionPercentage,
                  animation: true,
                  animationDuration: AppDurations.progress.inMilliseconds,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: completionPercentage == 1.0
                      ? theme.colorScheme.tertiary
                      : theme.colorScheme.primary,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  center: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${(completionPercentage * 100).round()}%',
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(AppSpacing.xs),
                      Text(
                        '$completedCount/$totalPrayers',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(AppSpacing.xl),
            Center(
              child: Text(
                statusMessage,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            if (points > 0) ...[
              const Gap(AppSpacing.md),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: AppIconSizes.sm,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                      const Gap(6),
                      Text(
                        l10n.todayPoints(points),
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
