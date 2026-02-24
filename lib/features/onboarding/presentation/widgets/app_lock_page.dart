import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';
import 'package:salat_tracker/features/security/security.dart';
import 'package:salat_tracker/features/settings/settings.dart';

/// App Lock opt-in page.
///
/// After PIN setup, checks for biometric availability and offers enrollment.
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

  Future<void> _enableAppLock(BuildContext context, WidgetRef ref) async {
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

    // Check biometric availability and offer enrollment
    if (context.mounted) {
      final biometricsAvailable = await securityRepository
          .isBiometricsAvailable();
      if (biometricsAvailable && context.mounted) {
        final enableBiometrics = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.fingerprint),
            title: Text(S.of(context).settingsBiometricUnlock),
            content: Text(S.of(context).securityBiometricReason),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(S.of(context).onboardingMaybeLater),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(S.of(context).generalYes),
              ),
            ],
          ),
        );

        if (enableBiometrics ?? false) {
          await ref
              .read(settingsProvider.notifier)
              .updateBiometricUnlockEnabled(enabled: true);
        }
      }
    }

    onNext();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    return OnboardingStepScaffold(
      icon: Icons.lock_outline,
      title: l10n.onboardingAppLockTitle,
      body: l10n.onboardingAppLockBody,
      primaryLabel: l10n.onboardingEnableAppLock,
      onPrimary: () => _enableAppLock(context, ref),
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
