import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

class TodayCelebrationCard extends StatelessWidget {
  const TodayCelebrationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);
    final statusChipTheme = theme.extension<StatusChipTheme>();

    return Card(
          color: statusChipTheme?.completeBackground,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.celebration_outlined,
                  color: statusChipTheme?.completeForeground,
                  size: AppIconSizes.xl,
                ),
                const Gap(AppSpacing.md),
                Text(
                  l10n.todayComplete,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: statusChipTheme?.completeForeground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .shimmer(
          duration: 2000.ms,
          color: statusChipTheme?.completeForeground.withValues(alpha: 0.3),
        );
  }
}
