import 'package:flutter/material.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';

/// A calendar cell representing a single day with prayer completion status.
///
/// Displays visual indicators for complete, partial, or no prayers logged.
class CalendarDayCell extends StatelessWidget {
  /// Creates a [CalendarDayCell].
  const CalendarDayCell({
    required this.day,
    required this.prayerDay,
    required this.statusChipTheme,
    this.isToday = false,
    this.isSelected = false,
    super.key,
  });

  /// The date this cell represents.
  final DateTime day;

  /// Prayer data for this day, if any.
  final PrayerDay? prayerDay;

  /// Theme for status colors.
  final StatusChipTheme? statusChipTheme;

  /// Whether this cell represents today.
  final bool isToday;

  /// Whether this cell is currently selected.
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color? backgroundColor;
    if (prayerDay != null) {
      if (prayerDay!.isComplete) {
        backgroundColor = statusChipTheme?.completeBackground.withValues(
          alpha: 0.3,
        );
      } else if (prayerDay!.entries.isNotEmpty) {
        backgroundColor = statusChipTheme?.partialBackground.withValues(
          alpha: 0.3,
        );
      }
    }

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: isToday
            ? Border.all(
                color: theme.colorScheme.primary,
                width: 2,
              )
            : null,
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface,
            fontWeight: isSelected || isToday ? FontWeight.bold : null,
          ),
        ),
      ),
    );
  }
}
