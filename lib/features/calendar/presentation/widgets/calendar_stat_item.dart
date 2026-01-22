import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/shared/shared.dart';

/// A statistic display item showing an icon, value, and label.
///
/// Used in calendar day detail to show completion count and points.
class CalendarStatItem extends StatelessWidget {
  /// Creates a [CalendarStatItem].
  const CalendarStatItem({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  /// Icon to display.
  final IconData icon;

  /// Label text below the value.
  final String label;

  /// Value text to display prominently.
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(icon, size: AppIconSizes.xl),
        const Gap(AppSpacing.xs),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
