import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/shared/shared.dart';

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
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),

          // Icon
          Icon(
            Icons.notifications_outlined,
            size: AppIconSizes.display,
            color: theme.colorScheme.primary,
          ),
          const Gap(AppSpacing.xl),

          // Title
          Text(
            l10n.onboardingNotificationsTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(AppSpacing.md),

          // Body
          Text(
            l10n.onboardingNotificationsBody,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),

          const Spacer(),

          // Enable button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () async {
                await ref
                    .read(settingsProvider.notifier)
                    .toggleNotifications(enabled: true);
                onNext();
              },
              icon: const Icon(Icons.notifications_active),
              label: Text(l10n.onboardingEnableNotifications),
            ),
          ),
          const Gap(AppSpacing.sm),

          // Skip button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onNext,
              child: Text(l10n.onboardingMaybeLater),
            ),
          ),
          const Gap(AppSpacing.md),

          // Back button
          TextButton(
            onPressed: onBack,
            child: Text(l10n.onboardingBack),
          ),
        ],
      ),
    );
  }
}
