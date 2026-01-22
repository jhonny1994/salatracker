import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Error state for the Settings screen.
class SettingsErrorState extends StatelessWidget {
  /// Creates a [SettingsErrorState].
  const SettingsErrorState({required this.l10n, super.key});

  /// Localization instance for error messages.
  final S l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppIconSizes.hero,
              color: theme.colorScheme.error,
            ),
            const Gap(AppSpacing.lg),
            Text(l10n.errorLoadingSettings),
          ],
        ),
      ),
    );
  }
}
