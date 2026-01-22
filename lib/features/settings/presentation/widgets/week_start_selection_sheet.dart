import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/settings/data/providers/settings_providers.dart';
import 'package:salat_tracker/shared/shared.dart';

/// A modal bottom sheet for selecting the calendar week start day.
class WeekStartSelectionSheet extends ConsumerWidget {
  /// Creates a [WeekStartSelectionSheet].
  const WeekStartSelectionSheet({
    required this.currentStart,
    super.key,
  });

  /// The currently selected week start day (DateTime weekday).
  final int currentStart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    // Options: Saturday, Sunday, Monday
    final options = [
      (DateTime.saturday, l10n.weekStartSaturday),
      (DateTime.sunday, l10n.weekStartSunday),
      (DateTime.monday, l10n.weekStartMonday),
    ];

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              l10n.settingsWeekStart,
              style: theme.textTheme.titleLarge,
            ),
          ),
          const Divider(height: 1),
          ...options.map(
            (option) => ListTile(
              title: Text(option.$2),
              trailing: option.$1 == currentStart
                  ? Icon(
                      Icons.check,
                      color: theme.colorScheme.primary,
                    )
                  : null,
              onTap: () async {
                await ref
                    .read(settingsProvider.notifier)
                    .updateWeekStart(option.$1);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          ),
          const Gap(AppSpacing.md),
        ],
      ),
    );
  }
}
