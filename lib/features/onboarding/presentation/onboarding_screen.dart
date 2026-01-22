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

  void _goToPage(int index) {
    unawaited(
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
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
                      margin: EdgeInsets.only(
                        right: entry.key < OnboardingStep.values.length - 1
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
                onPageChanged: (index) {
                  // Sync controller with page
                  final controller = ref.read(
                    onboardingControllerProvider.notifier,
                  );
                  while (ref.read(onboardingControllerProvider).index < index) {
                    controller.nextStep();
                  }
                  while (ref.read(onboardingControllerProvider).index > index) {
                    controller.previousStep();
                  }
                },
                children: [
                  WelcomePage(onNext: () => _goToPage(1)),
                  PrayerTimesPage(
                    onNext: () => _goToPage(2),
                    onBack: () => _goToPage(0),
                  ),
                  NotificationsPage(
                    onNext: () => _goToPage(3),
                    onBack: () => _goToPage(1),
                  ),
                  AppLockPage(
                    onNext: () => _goToPage(4),
                    onBack: () => _goToPage(2),
                  ),
                  ConfirmationPage(
                    onComplete: _completeOnboarding,
                    onBack: () => _goToPage(3),
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
