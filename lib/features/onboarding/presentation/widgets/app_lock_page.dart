import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/onboarding/onboarding.dart';
import 'package:salat_tracker/features/security/security.dart';
import 'package:salat_tracker/features/settings/settings.dart';

/// App Lock opt-in page.
///
/// After PIN setup, checks for biometric availability and offers enrollment.
class AppLockPage extends ConsumerStatefulWidget {
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
  ConsumerState<AppLockPage> createState() => _AppLockPageState();
}

class _AppLockPageState extends ConsumerState<AppLockPage> {
  bool _submitting = false;

  Future<void> _enableAppLock() async {
    final pin = await showDialog<String>(
      context: context,
      builder: (_) => const PinSetupDialog(),
    );
    if (pin == null) {
      return;
    }

    setState(() => _submitting = true);

    try {
      final securityRepository = ref.read(securityRepositoryProvider);
      await securityRepository.setPin(pin);
      await ref
          .read(settingsProvider.notifier)
          .updateAppLockEnabled(enabled: true);

      if (!mounted) {
        return;
      }

      final biometricsAvailable = await securityRepository
          .isBiometricsAvailable();
      if (biometricsAvailable && mounted) {
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
          if (!mounted) {
            return;
          }
        }
      }

      widget.onNext();
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(content: Text(S.of(context).errorLoadingSettings)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  Future<void> _skipAppLock() async {
    setState(() => _submitting = true);

    try {
      await ref
          .read(settingsProvider.notifier)
          .updateAppLockEnabled(enabled: false);
      if (mounted) {
        widget.onNext();
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return OnboardingStepScaffold(
      icon: Icons.lock_outline,
      title: l10n.onboardingAppLockTitle,
      body: l10n.onboardingAppLockBody,
      primaryLabel: l10n.onboardingEnableAppLock,
      onPrimary: _submitting ? null : _enableAppLock,
      secondaryLabel: l10n.onboardingMaybeLater,
      onSecondary: _submitting ? null : _skipAppLock,
      backLabel: l10n.onboardingBack,
      onBack: widget.onBack,
      isBusy: _submitting,
      busyLabel: l10n.generalLoading,
    );
  }
}
