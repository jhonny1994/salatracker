import 'package:flutter/material.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/calendar/calendar.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/shared/shared.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({
    required this.focusedDay,
    required this.selectedDay,
    required this.prayerDays,
    required this.onDaySelected,
    super.key,
  });

  final DateTime focusedDay;
  final DateTime selectedDay;
  final Map<DateTime, PrayerDay> prayerDays;
  final void Function(DateTime, DateTime) onDaySelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusChipTheme = theme.extension<StatusChipTheme>();

    return TableCalendar<void>(
      firstDay: DateTime(2020),
      lastDay: DateTime(2100),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: onDaySelected,
      calendarStyle: CalendarStyle(
        // Today
        todayDecoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        // Selected
        selectedDecoration: BoxDecoration(
          color: theme.colorScheme.primary,
          shape: BoxShape.circle,
        ),
        // Markers for status
        markerDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: theme.textTheme.titleLarge!,
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: theme.colorScheme.onSurface,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: theme.colorScheme.onSurface,
        ),
      ),
      calendarBuilders: CalendarBuilders<void>(
        defaultBuilder: (context, day, focusedDay) => CalendarDayCell(
          day: day,
          prayerDay: prayerDays[day.dateOnly],
          statusChipTheme: statusChipTheme,
        ),
        todayBuilder: (context, day, focusedDay) => CalendarDayCell(
          day: day,
          prayerDay: prayerDays[day.dateOnly],
          statusChipTheme: statusChipTheme,
          isToday: true,
        ),
        selectedBuilder: (context, day, focusedDay) => CalendarDayCell(
          day: day,
          prayerDay: prayerDays[day.dateOnly],
          statusChipTheme: statusChipTheme,
          isSelected: true,
        ),
      ),
    );
  }
}
