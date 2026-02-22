import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Displays today's prayer completion progress with a circular indicator.
///
/// Shows percentage, prayer count, status message, and optional points.
class TodayProgressCard extends StatelessWidget {
  /// Creates a [TodayProgressCard].
  const TodayProgressCard({
    required this.completedCount,
    required this.totalPrayers,
    required this.completionPercentage,
    required this.points,
    super.key,
  });

  /// Number of prayers completed today.
  final int completedCount;

  /// Total number of prayers for the day.
  final int totalPrayers;

  /// Completion percentage (0.0 to 1.0).
  final double completionPercentage;

  /// Points earned today.
  final int points;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final percentText = NumberFormat.percentPattern(locale).format(
      completionPercentage,
    );
    final statusMessage = switch (completedCount) {
      0 => l10n.todayNone,
      5 => l10n.todayComplete,
      _ => l10n.todayPartial(completedCount),
    };

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSectionHeader(title: l10n.todayProgress),
          const Gap(AppSpacing.xl),
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
                      percentText,
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(AppSpacing.xs),
                    Text(
                      l10n.todayCompletionRatio(completedCount, totalPrayers),
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
              child: AppStatusBadge(
                label: l10n.todayPoints(points),
                icon: Icons.star_rounded,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
