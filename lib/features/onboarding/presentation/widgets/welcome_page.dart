import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Welcome page - first step of onboarding.
class WelcomePage extends StatelessWidget {
  /// Creates a [WelcomePage].
  const WelcomePage({required this.onNext, super.key});

  /// Callback when user taps Next.
  final VoidCallback onNext;

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
            Icons.mosque_outlined,
            size: AppIconSizes.displayLarge,
            color: theme.colorScheme.primary,
          ),
          const Gap(AppSpacing.xl),

          // Title
          Text(
            l10n.onboardingWelcomeTitle,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(AppSpacing.md),

          // Body
          Text(
            l10n.onboardingWelcomeBody,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),

          const Spacer(),

          // Next button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onNext,
              child: Text(l10n.onboardingNext),
            ),
          ),
        ],
      ),
    );
  }
}
