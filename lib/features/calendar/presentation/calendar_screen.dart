import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/calendar/calendar.dart';
import 'package:salat_tracker/shared/shared.dart';

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
      body: calendarState.when(
        loading: () => const CalendarLoadingState(),
        error: (error, _) => const CalendarErrorState(),
        data: (prayerDays) => Column(
          children: [
            CalendarView(
              focusedDay: focusedDay,
              selectedDay: selectedDay,
              prayerDays: prayerDays,
              onDaySelected: (selected, focused) {
                ref
                    .read(selectedDayControllerProvider.notifier)
                    .selectDay(selected);
              },
            ),
            const Gap(AppSpacing.lg),
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
