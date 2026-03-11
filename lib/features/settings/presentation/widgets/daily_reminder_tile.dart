import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    this.onLongPress,
    this.selectionMode = false,
    this.selected = false,
    this.onSelectionChanged,
    super.key,
  });

  final DailyReminderConfig reminder;
  final String label;
  final VoidCallback onTap;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onLongPress;
  final bool selectionMode;
  final bool selected;
  final ValueChanged<bool>? onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          children: [
            Row(
              children: [
                if (selectionMode)
                  Checkbox.adaptive(
                    value: selected,
                    onChanged: (value) =>
                        onSelectionChanged?.call(value ?? false),
                  ),
                const Icon(Icons.nightlight_round_outlined),
                const Gap(AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: theme.textTheme.titleMedium),
                      const Gap(AppSpacing.xs),
                      Text(reminder.time.format(context)),
                    ],
                  ),
                ),
                Switch.adaptive(value: reminder.enabled, onChanged: onChanged),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
