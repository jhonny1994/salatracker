import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/today/today.dart';
import 'package:salat_tracker/shared/shared.dart';

class NotificationEntryScreen extends ConsumerStatefulWidget {
  const NotificationEntryScreen({
    super.key,
    this.debugInitialIntent,
    this.debugDisablePersistence = false,
  });

  @visibleForTesting
  final NotificationIntent? debugInitialIntent;

  @visibleForTesting
  final bool debugDisablePersistence;

  @override
  ConsumerState<NotificationEntryScreen> createState() =>
      _NotificationEntryScreenState();
}

class _NotificationEntryScreenState
    extends ConsumerState<NotificationEntryScreen> {
  NotificationIntent? _intent;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    unawaited(_loadIntent());
  }

  Future<void> _loadIntent() async {
    final debugIntent = widget.debugInitialIntent;
    if (debugIntent != null) {
      if (mounted) {
        setState(() {
          _intent = debugIntent;
          _loading = false;
        });
      }
      return;
    }

    final store = ref.read(notificationEntryIntentStoreProvider);
    final pending = store.readPending();
    if (mounted) {
      setState(() {
        _intent = pending;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final intent = _intent;
    if (intent == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.notificationEntryTitleFallback)),
        body: Center(
          child: FilledButton(
            onPressed: () => context.go('/today'),
            child: Text(l10n.notificationActionOpenToday),
          ),
        ),
      );
    }

    final content = switch (intent.type) {
      NotificationIntentType.prayerReminder => _NotificationEntryContent(
        icon: Icons.mosque_outlined,
        title: _prayerTitle(intent, l10n),
        body: l10n.notificationEntryPrayerBody,
        primaryLabel: l10n.notificationActionMarkDone,
        onPrimary: () => _markPrayerDone(intent),
        secondaryLabel: l10n.notificationActionSnooze,
        onSecondary: () => _snooze(intent),
      ),
      NotificationIntentType.dailyCheckinReminder => _NotificationEntryContent(
        icon: Icons.nightlight_round_outlined,
        title: l10n.notificationEntryTitleDaily,
        body: l10n.dailyReminderBody,
        primaryLabel: l10n.notificationActionOpenToday,
        onPrimary: () => _openToday(intent),
        secondaryLabel: l10n.notificationActionSnooze,
        onSecondary: () => _snooze(intent),
      ),
      NotificationIntentType.requiredUpdate => _NotificationEntryContent(
        icon: Icons.system_update_outlined,
        title: l10n.updateRequiredBlocked,
        body: l10n.updateRequiredGrace,
        primaryLabel: l10n.updateActionNow,
        onPrimary: () => _openUpdateRequired(intent),
      ),
      NotificationIntentType.badgeUnlocked => _NotificationEntryContent(
        icon: Icons.workspace_premium_outlined,
        title: l10n.badgesTitle,
        body: l10n.notificationEntryFallbackBody,
        primaryLabel: l10n.notificationActionOpenToday,
        onPrimary: () => _openBadges(intent),
      ),
      NotificationIntentType.genericFallback => _NotificationEntryContent(
        icon: Icons.notifications_outlined,
        title: l10n.notificationEntryTitleFallback,
        body: l10n.notificationEntryFallbackBody,
        primaryLabel: l10n.notificationActionOpenToday,
        onPrimary: () => _openToday(intent),
      ),
    };

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: content,
        ),
      ),
    );
  }

  String _prayerTitle(NotificationIntent intent, S l10n) {
    final prayer = intent.prayerType;
    if (prayer == null) {
      return l10n.notificationEntryTitlePrayerGeneric;
    }

    final prayerName = switch (prayer) {
      PrayerType.fajr => l10n.prayerFajr,
      PrayerType.dhuhr => l10n.prayerDhuhr,
      PrayerType.asr => l10n.prayerAsr,
      PrayerType.maghrib => l10n.prayerMaghrib,
      PrayerType.isha => l10n.prayerIsha,
    };
    return l10n.notificationEntryTitlePrayer(prayerName);
  }

  Future<void> _markPrayerDone(NotificationIntent intent) async {
    final prayerType = intent.prayerType;
    if (prayerType != null) {
      final intentDate = intent.dateIso != null
          ? DateTime.tryParse(intent.dateIso!)
          : null;
      await ref
          .read(todayControllerProvider.notifier)
          .markPrayerDone(prayerType, date: intentDate);
    }
    await _finalize(intent);
    if (mounted) {
      context.go('/today');
    }
  }

  Future<void> _openToday(NotificationIntent intent) async {
    await _finalize(intent);
    if (mounted) {
      context.go('/today');
    }
  }

  Future<void> _snooze(NotificationIntent intent) async {
    final store = ref.read(notificationEntryIntentStoreProvider);
    final l10n = S.of(context);
    final rootIntentId = intent.rootIntentId;
    if (store.hasSnoozeActive(rootIntentId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.notificationSnoozeAlreadyActive)),
      );
      return;
    }

    final notificationService = ref.read(notificationServiceProvider);
    final id = DateTime.now().millisecondsSinceEpoch.remainder(1 << 30);
    final snoozedIntent = intent.copyWith(
      intentId:
          '$rootIntentId${NotificationIntent.snoozeSeparator}'
          '${DateTime.now().millisecondsSinceEpoch}',
      sentAtIso: DateTime.now().toIso8601String(),
    );

    await notificationService.schedulePrayer(
      id: id,
      title: l10n.notificationSnoozeTitle,
      body: l10n.notificationSnoozeBody,
      scheduledAt: DateTime.now().add(const Duration(minutes: 10)),
      payload: snoozedIntent.toPayload(),
    );
    await store.setSnoozeActive(intentId: rootIntentId, notificationId: id);
    await _finalize(intent, clearSnooze: false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.notificationSnoozedFor10)),
      );
      context.go('/today');
    }
  }

  Future<void> _openUpdateRequired(NotificationIntent intent) async {
    await _finalize(intent);
    if (mounted) {
      context.go('/update-required');
    }
  }

  Future<void> _openBadges(NotificationIntent intent) async {
    await _finalize(intent);
    if (mounted) {
      context.go('/settings/badges');
    }
  }

  Future<void> _finalize(
    NotificationIntent intent, {
    bool clearSnooze = true,
  }) async {
    if (widget.debugDisablePersistence) {
      return;
    }

    final store = ref.read(notificationEntryIntentStoreProvider);
    await store.setLastHandledIntentId(intent.intentId);
    if (clearSnooze) {
      await store.clearSnooze(intent.rootIntentId);
    }
    await store.clearPending();
  }
}

class _NotificationEntryContent extends StatelessWidget {
  const _NotificationEntryContent({
    required this.icon,
    required this.title,
    required this.body,
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
  });

  final IconData icon;
  final String title;
  final String body;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.18),
            colorScheme.surface,
          ],
        ),
      ),
      child: AppFullScreenMessageLayout(
        top: Center(
          child: Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Icon(
              icon,
              size: AppIconSizes.hero,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        middle: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(body, textAlign: TextAlign.center),
          ],
        ),
        bottom: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed: onPrimary,
              child: Text(primaryLabel),
            ),
            if (secondaryLabel != null && onSecondary != null) ...[
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: onSecondary,
                child: Text(secondaryLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
