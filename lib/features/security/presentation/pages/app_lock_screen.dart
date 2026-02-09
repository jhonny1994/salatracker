import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/security/data/providers/security_providers.dart';
import 'package:salat_tracker/features/security/presentation/widgets/pin_pad.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Screen displayed when the application is locked.
/// Requires PIN or biometric authentication to unlock.
class AppLockScreen extends ConsumerStatefulWidget {
  const AppLockScreen({super.key});

  @override
  ConsumerState<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends ConsumerState<AppLockScreen> {
  bool _isError = false;
  bool _isBiometricsAvailable = false;

  @override
  void initState() {
    super.initState();
    unawaited(_checkBiometrics());
    // Attempt biometrics immediately on load if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_attemptBiometrics());
    });
  }

  Future<void> _checkBiometrics() async {
    final repo = ref.read(securityRepositoryProvider);
    final available = await repo.isBiometricsAvailable();
    if (mounted) {
      setState(() => _isBiometricsAvailable = available);
    }
  }

  Future<void> _attemptBiometrics() async {
    final repo = ref.read(securityRepositoryProvider);
    if (!await repo.hasPin()) {
      if (mounted) {
        ref.read(appLockControllerProvider.notifier).unlockApp();
      }
      return;
    }

    if (await repo.isBiometricsAvailable()) {
      final success = await repo.authenticateWithBiometrics(
        reason: S.current.securityBiometricReason,
      );
      if (success && mounted) {
        ref.read(appLockControllerProvider.notifier).unlockApp();
      }
    }
  }

  Future<void> _verifyPin(String pin) async {
    final repo = ref.read(securityRepositoryProvider);
    final isValid = await repo.verifyPin(pin);

    if (isValid) {
      ref.read(appLockControllerProvider.notifier).unlockApp();
    } else {
      if (mounted) {
        setState(() => _isError = true);
        // Reset error state after animation
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) setState(() => _isError = false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return PopScope(
      canPop: false, // Prevent going back from lock screen
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Icon(
                Icons.lock_outline_rounded,
                size: 64,
              ),
              const Gap(AppSpacing.md),
              Text(
                l10n.securityUnlockTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              PinPad(
                    length: 4,
                    onCompleted: _verifyPin,
                    isError: _isError,
                    bioAvailable: _isBiometricsAvailable,
                    onBio: _attemptBiometrics,
                  )
                  .animate(target: _isError ? 1 : 0)
                  .shake(duration: 500.ms, hz: 4, curve: Curves.easeInOut),
              const Gap(AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
