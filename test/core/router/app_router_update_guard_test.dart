import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/core/router/app_router.dart';
import 'package:salat_tracker/features/security/security.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/features/update/update.dart';

void main() {
  test('redirects to required update when blocked', () {
    final redirect = resolveAppRedirect(
      lockAsync: const AsyncData(AppLockStatus.unlocked),
      settingsAsync: AsyncData(
        Settings.defaults().copyWith(onboardingComplete: true),
      ),
      updateAsync: const AsyncData(
        UpdateDecision(
          status: UpdateStatus.requiredBlocked,
          action: UpdateAction.updateNow,
          message: 'blocked',
        ),
      ),
      matchedLocation: '/today',
    );

    expect(redirect, '/update-required');
  });

  test(
    'exits required update route to onboarding when onboarding incomplete',
    () {
      final redirect = resolveAppRedirect(
        lockAsync: const AsyncData(AppLockStatus.unlocked),
        settingsAsync: AsyncData(
          Settings.defaults().copyWith(onboardingComplete: false),
        ),
        updateAsync: const AsyncData(
          UpdateDecision(
            status: UpdateStatus.upToDate,
            action: UpdateAction.check,
            message: 'ok',
          ),
        ),
        matchedLocation: '/update-required',
      );

      expect(redirect, '/onboarding');
    },
  );
}
