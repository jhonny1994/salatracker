import 'package:flutter/material.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Error state for the Calendar screen with informative message.
class CalendarErrorState extends StatelessWidget {
  /// Creates a [CalendarErrorState].
  const CalendarErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return AppEmptyState(
      icon: Icons.error_outline,
      title: l10n.errorLoadingCalendar,
      message: l10n.calendarStreamRetry,
    );
  }
}
