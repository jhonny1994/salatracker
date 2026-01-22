import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Error state for the Calendar screen with informative message.
class CalendarErrorState extends StatelessWidget {
  /// Creates a [CalendarErrorState].
  const CalendarErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppIconSizes.hero,
              color: theme.colorScheme.error,
            ),
            const Gap(AppSpacing.lg),
            Text(l10n.errorLoadingCalendar),
            const Gap(AppSpacing.sm),
            Text(
              l10n.calendarStreamRetry,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
