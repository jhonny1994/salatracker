import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/onboarding/presentation/widgets/onboarding_step_scaffold.dart';
import 'package:salat_tracker/features/settings/settings.dart';

/// Notifications opt-in page.
class NotificationsPage extends ConsumerWidget {
  /// Creates a [NotificationsPage].
  const NotificationsPage({
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
      icon: Icons.notifications_outlined,
      title: l10n.onboardingNotificationsTitle,
      body: l10n.onboardingNotificationsBody,
      primaryLabel: l10n.onboardingEnableNotifications,
      onPrimary: () async {
        try {
          await ref
              .read(settingsProvider.notifier)
              .toggleNotifications(enabled: true);

          final settings = await ref.read(settingsProvider.future);
          if (!settings.notificationsEnabled) {
            return;
          }

          onNext();
        } on Object {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.errorLoadingSettings)),
            );
          }
        }
      },
      secondaryLabel: l10n.onboardingMaybeLater,
      onSecondary: onNext,
      backLabel: l10n.onboardingBack,
      onBack: onBack,
    );
  }
}
