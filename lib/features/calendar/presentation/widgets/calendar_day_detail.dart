import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/calendar/application/history_controller.dart';
import 'package:salat_tracker/features/calendar/calendar.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Displays detailed prayer status for a selected calendar day.
///
/// Allows toggling prayer completion for the selected day with confirmation
/// dialog for historical edits.
class CalendarDayDetail extends ConsumerWidget {
  /// Creates a [CalendarDayDetail].
  const CalendarDayDetail({
    required this.day,
    required this.prayerDay,
    super.key,
  });

  /// The date being displayed.
  final DateTime day;

  /// Prayer data for this day, if any.
  final PrayerDay? prayerDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    // If day is null, we treat it as empty but editable
    final entries = prayerDay?.entries ?? [];
    final completedCount = entries.where((e) => e.isCompleted).length;
    final points = prayerDay?.points ?? 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day header
          Text(
            day.toFormattedDate,
            style: theme.textTheme.titleLarge,
          ),
          const Gap(AppSpacing.lg),

          // Stats card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CalendarStatItem(
                    icon: Icons.check_circle,
                    label: l10n.calendarCompleted,
                    value: '$completedCount/5',
                  ),
                  CalendarStatItem(
                    icon: Icons.star,
                    label: l10n.calendarPoints,
                    value: '$points',
                  ),
                ],
              ),
            ),
          ),
          const Gap(AppSpacing.xl),

          // Prayer list
          Text(
            l10n.calendarPrayers,
            style: theme.textTheme.titleMedium,
          ),
          const Gap(AppSpacing.md),

          ...PrayerType.values.map((type) {
            final entry = entries.firstWhere(
              (e) => e.type == type,
              orElse: () => PrayerEntry(
                type: type,
                scheduledAt: DateTime.now(), // Placeholder
                isCompleted: false,
              ),
            );

            final isJumuah =
                type == PrayerType.dhuhr && day.weekday == DateTime.friday;
            final name = isJumuah ? l10n.prayerJumuah : type.name.toUpperCase();
            final isCompleted = entry.isCompleted;

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: ListTile(
                leading: Icon(
                  isCompleted
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: isCompleted
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                ),
                title: Text(
                  name,
                  style: isCompleted
                      ? null
                      : TextStyle(color: theme.colorScheme.onSurfaceVariant),
                ),
                subtitle: isCompleted && entry.checkedAt != null
                    ? Text(
                        l10n.calendarLoggedAt(entry.checkedAt!.toFormattedTime),
                      )
                    : null,
                onTap: () => _handleTap(context, ref, type, isCompleted),
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _handleTap(
    BuildContext context,
    WidgetRef ref,
    PrayerType type,
    bool currentStatus,
  ) async {
    final now = DateTime.now();
    final today = now.dateOnly;
    final isHistory = day.dateOnly.isBefore(today);

    if (isHistory) {
      final l10n = S.of(context);
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.historyEditWarningTitle),
          content: Text(l10n.historyEditWarningBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.actionCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.actionContinue),
            ),
          ],
        ),
      );

      if (confirmed != true) return;
    }

    // Perform toggle
    await ref
        .read(historyControllerProvider.notifier)
        .togglePrayer(date: day, prayerType: type);
  }
}
