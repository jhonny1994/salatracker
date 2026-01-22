import 'package:flutter/material.dart';

/// Loading state for the Calendar screen with circular indicator.
class CalendarLoadingState extends StatelessWidget {
  /// Creates a [CalendarLoadingState].
  const CalendarLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
