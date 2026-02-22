import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/security/security.dart';
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
  Duration? _lockoutRemaining;
  Timer? _lockoutTimer;

  @override
  void initState() {
    super.initState();
    unawaited(_checkBiometrics());
    unawaited(_refreshLockoutState());
    // Attempt biometrics immediately on load if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_attemptBiometrics());
    });
  }

  @override
  void dispose() {
    _lockoutTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkBiometrics() async {
    final biometricEnabled = await _isBiometricUnlockEnabled();
    final repo = ref.read(securityRepositoryProvider);
    final available = biometricEnabled && await repo.isBiometricsAvailable();
    if (mounted) {
      setState(() => _isBiometricsAvailable = available);
    }
  }

  Future<void> _attemptBiometrics() async {
    if (_lockoutRemaining != null) {
      return;
    }

    if (!await _isBiometricUnlockEnabled()) {
      return;
    }

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

  Future<bool> _isBiometricUnlockEnabled() async {
    return ref.read(securityRepositoryProvider).isBiometricUnlockEnabled();
  }

  Future<void> _verifyPin(String pin) async {
    if (_lockoutRemaining != null) {
      return;
    }

    final repo = ref.read(securityRepositoryProvider);
    final isValid = await repo.verifyPin(pin);

    if (isValid) {
      ref.read(appLockControllerProvider.notifier).unlockApp();
    } else {
      if (mounted) {
        setState(() => _isError = true);
        await _refreshLockoutState();

        // Reset error state after animation
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) setState(() => _isError = false);
        });
      }
    }
  }

  Future<void> _refreshLockoutState() async {
    final repo = ref.read(securityRepositoryProvider);
    final remaining = await repo.lockoutRemaining();

    if (!mounted) {
      return;
    }

    setState(() => _lockoutRemaining = remaining);

    _lockoutTimer?.cancel();
    if (remaining != null) {
      _lockoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        final value = await repo.lockoutRemaining();
        if (!mounted) {
          timer.cancel();
          return;
        }

        setState(() => _lockoutRemaining = value);
        if (value == null) {
          timer.cancel();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return PopScope(
      canPop: false, // Prevent going back from lock screen
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: AppSurfaceCard(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xxl,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.lock_outline_rounded,
                      size: 64,
                    ),
                    const Gap(AppSpacing.md),
                    Text(
                      l10n.securityUnlockTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(AppSpacing.xxl),
                    PinPad(
                          length: 6,
                          onCompleted: _verifyPin,
                          isError: _isError,
                          bioAvailable: _isBiometricsAvailable,
                          onBio: _attemptBiometrics,
                          enabled: _lockoutRemaining == null,
                        )
                        .animate(target: _isError ? 1 : 0)
                        .shake(
                          duration: 500.ms,
                          hz: 4,
                          curve: Curves.easeInOut,
                        ),
                    if (_lockoutRemaining != null)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.md),
                        child: AppInlineNotice(
                          icon: Icons.timer_outlined,
                          message: l10n.securityLockoutSeconds(
                            _lockoutRemaining!.inSeconds,
                          ),
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
