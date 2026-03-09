import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Daily reminder configuration screen.
class DailyRemindersScreen extends ConsumerWidget {
  /// Creates a [DailyRemindersScreen].
  const DailyRemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final settingsState = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsDailyReminders)),
      body: AppAsyncValue(
        value: settingsState,
        errorTitle: l10n.errorLoadingSettings,
        retry: () => ref.invalidate(settingsProvider),
        data: (settings) {
          final reminders = settings.effectiveDailyReminders;

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              AppSurfaceCard(
                child: Text(l10n.settingsDailyRemindersSubtitle),
              ),
              const Gap(AppSpacing.lg),
              if (reminders.isEmpty)
                AppSurfaceCard(
                  child: Text(l10n.settingsDailyRemindersEmpty),
                )
              else
                AppSurfaceCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (var i = 0; i < reminders.length; i++) ...[
                        DailyReminderTile(
                          reminder: reminders[i],
                          label: l10n.settingsDailyReminderLabel(i + 1),
                          onTap: () => _pickReminderTime(
                            context,
                            ref,
                            reminderId: reminders[i].id,
                            current: reminders[i].time,
                          ),
                          onChanged: (enabled) => ref
                              .read(settingsProvider.notifier)
                              .toggleDailyReminder(
                                reminderId: reminders[i].id,
                                enabled: enabled,
                              ),
                          onRemove: () => ref
                              .read(settingsProvider.notifier)
                              .removeDailyReminder(reminderId: reminders[i].id),
                        ),
                        if (i < reminders.length - 1)
                          const Divider(
                            height: 1,
                            indent: AppTouchTargets.comfortable,
                          ),
                      ],
                    ],
                  ),
                ),
              const Gap(AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _addReminder(context, ref),
                  icon: const Icon(Icons.add),
                  label: Text(l10n.settingsAddDailyReminder),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addReminder(BuildContext context, WidgetRef ref) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: Settings.defaults().effectiveDailyReminders.first.time,
    );

    if (picked != null) {
      final current = await ref.read(settingsProvider.future);
      final hasDuplicate = current.effectiveDailyReminders.any(
        (reminder) => reminder.time == picked,
      );

      if (hasDuplicate) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).settingsReminderDuplicateTime),
            ),
          );
        }
        return;
      }

      await ref.read(settingsProvider.notifier).addDailyReminder(time: picked);
    }
  }

  Future<void> _pickReminderTime(
    BuildContext context,
    WidgetRef ref, {
    required int reminderId,
    required TimeOfDay current,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: current,
    );

    if (picked != null) {
      final currentSettings = await ref.read(settingsProvider.future);
      final hasDuplicate = currentSettings.effectiveDailyReminders.any(
        (reminder) => reminder.id != reminderId && reminder.time == picked,
      );

      if (hasDuplicate) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).settingsReminderDuplicateTime),
            ),
          );
        }
        return;
      }

      await ref
          .read(settingsProvider.notifier)
          .updateDailyReminderTime(reminderId: reminderId, time: picked);
    }
  }
}
