import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Error state for the Today screen with retry functionality.
class TodayErrorState extends ConsumerWidget {
  /// Creates a [TodayErrorState].
  const TodayErrorState({required this.onRetry, super.key});

  /// Callback triggered when user taps the retry button.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return AppEmptyState(
      icon: Icons.error_outline,
      title: l10n.errorLoadingData,
      message: l10n.calendarStreamRetry,
      action: FilledButton.icon(
        onPressed: onRetry,
        icon: Icon(Icons.refresh, color: theme.colorScheme.onPrimary),
        label: Text(l10n.errorRetry),
      ),
    );
  }
}
