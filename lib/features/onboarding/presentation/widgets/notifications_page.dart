import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/onboarding/onboarding.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Notifications opt-in page.
class NotificationsPage extends ConsumerStatefulWidget {
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
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  bool _submitting = false;

  Future<void> _enableNotifications() async {
    setState(() => _submitting = true);
    final l10n = S.of(context);

    try {
      await ref
          .read(settingsProvider.notifier)
          .toggleNotifications(enabled: true);

      final settings = await ref.read(settingsProvider.future);
      if (!mounted) {
        return;
      }

      if (!settings.notificationsEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.onboardingNotificationsPermissionDenied)),
        );
        return;
      }

      widget.onNext();
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.errorLoadingSettings)));
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  Future<void> _skipNotifications() async {
    setState(() => _submitting = true);

    try {
      await ref
          .read(settingsProvider.notifier)
          .toggleNotifications(enabled: true);
      if (mounted) {
        widget.onNext();
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  Future<void> _pickLateReminderTime() async {
    final current = ref.read(onboardingLateReminderTimeProvider);
    final picked = await showTimePicker(
      context: context,
      initialTime: current,
    );

    if (picked != null) {
      ref.read(onboardingLateReminderTimeProvider.notifier).updateTime(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final lateReminderTime = ref.watch(onboardingLateReminderTimeProvider);

    return OnboardingStepScaffold(
      icon: Icons.notifications_outlined,
      title: l10n.onboardingNotificationsTitle,
      body: l10n.onboardingNotificationsBody,
      primaryLabel: l10n.onboardingEnableNotifications,
      onPrimary: _submitting ? null : _enableNotifications,
      secondaryLabel: l10n.onboardingMaybeLater,
      onSecondary: _skipNotifications,
      backLabel: l10n.onboardingBack,
      onBack: widget.onBack,
      isBusy: _submitting,
      busyLabel: l10n.generalLoading,
      content: AppSurfaceCard(
        padding: EdgeInsets.zero,
        child: ListTile(
          leading: const Icon(Icons.nightlight_round_outlined),
          title: Text(l10n.onboardingLateReminderTitle),
          subtitle: Text(l10n.onboardingLateReminderBody),
          trailing: AppStatusBadge(
            label: lateReminderTime.format(context),
            isPill: false,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            foregroundColor: theme.colorScheme.onSurfaceVariant,
          ),
          onTap: _pickLateReminderTime,
        ),
      ),
    );
  }
}
