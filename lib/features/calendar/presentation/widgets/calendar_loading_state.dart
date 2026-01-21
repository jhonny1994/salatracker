import 'package:flutter/material.dart';

class CalendarLoadingState extends StatelessWidget {
  const CalendarLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
