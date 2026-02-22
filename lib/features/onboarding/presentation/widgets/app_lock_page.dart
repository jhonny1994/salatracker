import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';
import 'package:salat_tracker/features/security/security.dart';
import 'package:salat_tracker/features/settings/settings.dart';

/// App Lock opt-in page.
///
/// Note: Full app lock implementation is in Phase 5. This page provides
/// the opt-in UI that will be wired up later.
class AppLockPage extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    return OnboardingStepScaffold(
      icon: Icons.lock_outline,
      title: l10n.onboardingAppLockTitle,
      body: l10n.onboardingAppLockBody,
      primaryLabel: l10n.onboardingEnableAppLock,
      onPrimary: () async {
        final pin = await showDialog<String>(
          context: context,
          builder: (_) => const PinSetupDialog(),
        );
        if (pin == null) {
          return;
        }

        final securityRepository = ref.read(securityRepositoryProvider);
        await securityRepository.setPin(pin);
        await ref
            .read(settingsProvider.notifier)
            .updateAppLockEnabled(enabled: true);
        onNext();
      },
      secondaryLabel: l10n.onboardingMaybeLater,
      onSecondary: () async {
        await ref
            .read(settingsProvider.notifier)
            .updateAppLockEnabled(enabled: false);
        onNext();
      },
      backLabel: l10n.onboardingBack,
      onBack: onBack,
    );
  }
}
