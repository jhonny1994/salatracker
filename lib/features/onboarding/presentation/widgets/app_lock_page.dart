import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

/// App Lock opt-in page.
///
/// Note: Full app lock implementation is in Phase 5. This page provides
/// the opt-in UI that will be wired up later.
class AppLockPage extends StatelessWidget {
  /// Creates an [AppLockPage].
  const AppLockPage({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  /// Callback when user taps Next.
  final VoidCallback onNext;

  /// Callback when user taps Back.
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),

          // Icon
          Icon(
            Icons.lock_outline,
            size: AppIconSizes.display,
            color: theme.colorScheme.primary,
          ),
          const Gap(AppSpacing.xl),

          // Title
          Text(
            l10n.onboardingAppLockTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(AppSpacing.md),

          // Body
          Text(
            l10n.onboardingAppLockBody,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),

          const Spacer(),

          // Enable button (placeholder - Phase 5)
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onNext,
              icon: const Icon(Icons.fingerprint),
              label: Text(l10n.onboardingEnableAppLock),
            ),
          ),
          const Gap(AppSpacing.sm),

          // Skip button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onNext,
              child: Text(l10n.onboardingMaybeLater),
            ),
          ),
          const Gap(AppSpacing.md),

          // Back button
          TextButton(
            onPressed: onBack,
            child: Text(l10n.onboardingBack),
          ),
        ],
      ),
    );
  }
}
