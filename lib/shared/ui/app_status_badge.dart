import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/shared/design_constants.dart';

/// A reusable pill-shaped badge component for indicating status, metrics,
/// or state labels (e.g., 'Enabled', '14:30', '150 Points').
///
/// Eliminates duplicate `Container` + `BoxDecoration` styling across the app.
class AppStatusBadge extends StatelessWidget {
  /// Creates an [AppStatusBadge].
  const AppStatusBadge({
    required this.label,
    super.key,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.isPill = true,
  });

  /// The text to display inside the badge.
  final String label;

  /// Optional leading icon.
  final IconData? icon;

  /// Custom background color. Defaults to [ColorScheme.primaryContainer].
  final Color? backgroundColor;

  /// Custom foreground (text/icon) color.
  /// Defaults to [ColorScheme.onPrimaryContainer].
  final Color? foregroundColor;

  /// Whether the badge should have fully rounded 'pill' corners.
  /// If false, uses standard MD3 medium corners.
  final bool isPill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final effectiveBgColor =
        backgroundColor ?? theme.colorScheme.primaryContainer;
    final effectiveFgColor =
        foregroundColor ?? theme.colorScheme.onPrimaryContainer;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(isPill ? 100.0 : AppRadius.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: AppIconSizes.sm,
              color: effectiveFgColor,
            ),
            const Gap(AppSpacing.xs),
          ],
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: effectiveFgColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
