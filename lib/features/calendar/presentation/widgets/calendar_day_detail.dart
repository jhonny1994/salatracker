import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/calendar/calendar.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/shared/shared.dart';

class CalendarDayDetail extends StatelessWidget {
  const CalendarDayDetail({
    required this.day,
    required this.prayerDay,
    super.key,
  });

  final DateTime day;
  final PrayerDay? prayerDay;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    if (prayerDay == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_available,
              size: AppIconSizes.hero,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const Gap(AppSpacing.lg),
            Text(
              l10n.calendarNoData,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

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
                    value: '${prayerDay!.entries.length}/5',
                  ),
                  CalendarStatItem(
                    icon: Icons.star,
                    label: l10n.calendarPoints,
                    value: '${prayerDay!.points}',
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

          if (prayerDay!.entries.isEmpty)
            Text(l10n.calendarNoPrayers)
          else
            ...prayerDay!.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(entry.type.name.toUpperCase()),
                  subtitle: Text(
                    l10n.calendarLoggedAt(
                      (entry.checkedAt ?? entry.scheduledAt).toFormattedTime,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
