import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/calendar/calendar.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Historical view of prayer performance.
///
/// Provides a monthly calendar view and detailed daily breakdown, allowing
/// users to track their consistency over time.
class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final calendarState = ref.watch(calendarDaysProvider);
    final selectedDay = ref.watch(selectedDayControllerProvider);
    final focusedDay = selectedDay.dateOnly;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navCalendar),
        actions: [
          IconButton(
            onPressed: () => ref
                .read(selectedDayControllerProvider.notifier)
                .selectDay(DateTime.now()),
            icon: const Icon(Icons.today),
            tooltip: l10n.today,
          ),
        ],
      ),
      body: AppAsyncValue(
        value: calendarState,
        errorTitle: l10n.errorLoadingCalendar,
        errorMessage: l10n.calendarStreamRetry,
        loading: (_) => const Column(
          children: [
            Gap(AppSpacing.md),
            LocationContextBanner(),
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
        error: (_, _) => Column(
          children: [
            const Gap(AppSpacing.md),
            const LocationContextBanner(),
            Expanded(
              child: AppEmptyState(
                icon: Icons.error_outline,
                title: l10n.errorLoadingCalendar,
                message: l10n.calendarStreamRetry,
              ),
            ),
          ],
        ),
        data: (prayerDays) => Column(
          children: [
            const Gap(AppSpacing.md),
            const LocationContextBanner(),
            const Gap(AppSpacing.sm),
            CalendarView(
              focusedDay: focusedDay,
              selectedDay: selectedDay,
              prayerDays: prayerDays,
              weekStart:
                  ref.watch(settingsProvider).asData?.value.weekStart ??
                  DateTime.sunday,
              onDaySelected: (selected, focused) {
                ref
                    .read(selectedDayControllerProvider.notifier)
                    .selectDay(selected);
              },
            ),
            const Gap(AppSpacing.sm),
            Expanded(
              child: CalendarDayDetail(
                day: selectedDay,
                prayerDay: prayerDays[selectedDay.dateOnly],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
