import 'package:flutter/material.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';

/// Welcome page - first step of onboarding.
class WelcomePage extends StatelessWidget {
  /// Creates a [WelcomePage].
  const WelcomePage({required this.onNext, super.key});

  /// Callback when user taps Next.
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return OnboardingStepScaffold(
      icon: Icons.mosque_outlined,
      title: l10n.onboardingWelcomeTitle,
      body: l10n.onboardingWelcomeBody,
      primaryLabel: l10n.onboardingNext,
      onPrimary: onNext,
    );
  }
}
