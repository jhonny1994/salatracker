import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/shared/shared.dart';

/// A settings list tile for a single daily reminder.
class DailyReminderTile extends StatelessWidget {
  /// Creates a [DailyReminderTile].
  const DailyReminderTile({
    required this.reminder,
    required this.label,
    required this.onTap,
    required this.onChanged,
    required this.onRemove,
    super.key,
  });

  final DailyReminderConfig reminder;
  final String label;
  final VoidCallback onTap;
  final ValueChanged<bool> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.nightlight_round_outlined),
                const Gap(AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: theme.textTheme.titleMedium),
                      const Gap(AppSpacing.xs),
                      Text(
                        l10n.dailyReminderTileSubtitle(
                          reminder.time.format(context),
                        ),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Switch.adaptive(
                  value: reminder.enabled,
                  onChanged: onChanged,
                ),
                IconButton(
                  tooltip: l10n.actionRemove,
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
