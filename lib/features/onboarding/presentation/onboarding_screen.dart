import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salat_tracker/features/onboarding/onboarding.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Main onboarding screen with horizontal PageView.
class OnboardingScreen extends ConsumerStatefulWidget {
  /// Creates an [OnboardingScreen].
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goToPage(int index) async {
    ref.read(onboardingControllerProvider.notifier).setStepByIndex(index);

    if (!mounted) {
      return;
    }

    if (!_pageController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _pageController.hasClients) {
          unawaited(
            _pageController.animateToPage(
              index,
              duration: AppDurations.smooth,
              curve: Curves.easeInOut,
            ),
          );
        }
      });
      return;
    }

    await _pageController.animateToPage(
      index,
      duration: AppDurations.smooth,
      curve: Curves.easeInOut,
    );
  }

  Future<void> _completeOnboarding() async {
    await ref.read(settingsProvider.notifier).markOnboardingComplete();
    if (mounted) {
      context.go('/today');
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = ref.watch(onboardingControllerProvider);
    final stepIndex = OnboardingStep.values.indexOf(step);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_pageController.hasClients) {
        return;
      }
      final current =
          _pageController.page?.round() ?? _pageController.initialPage;
      if (current != stepIndex) {
        _pageController.jumpToPage(stepIndex);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: OnboardingStep.values.asMap().entries.map((entry) {
                  final isActive = entry.key <= stepIndex;
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsetsDirectional.only(
                        end: entry.key < OnboardingStep.values.length - 1
                            ? AppSpacing.xs
                            : 0,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(AppRadius.xs),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => ref
                    .read(onboardingControllerProvider.notifier)
                    .setStepByIndex(index),
                children: [
                  WelcomePage(onNext: () => unawaited(_goToPage(1))),
                  LocationPage(
                    onNext: () => unawaited(_goToPage(2)),
                    onBack: () => unawaited(_goToPage(0)),
                  ),
                  PrayerTimesPage(
                    onNext: () => unawaited(_goToPage(3)),
                    onBack: () => unawaited(_goToPage(1)),
                  ),
                  NotificationsPage(
                    onNext: () => unawaited(_goToPage(4)),
                    onBack: () => unawaited(_goToPage(2)),
                  ),
                  AppLockPage(
                    onNext: () => unawaited(_goToPage(5)),
                    onBack: () => unawaited(_goToPage(3)),
                  ),
                  ConfirmationPage(
                    onComplete: _completeOnboarding,
                    onBack: () => unawaited(_goToPage(4)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
