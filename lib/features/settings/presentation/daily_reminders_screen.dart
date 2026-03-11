import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Daily reminder configuration screen.
class DailyRemindersScreen extends ConsumerStatefulWidget {
  /// Creates a [DailyRemindersScreen].
  const DailyRemindersScreen({super.key});

  @override
  ConsumerState<DailyRemindersScreen> createState() =>
      _DailyRemindersScreenState();
}

class _DailyRemindersScreenState extends ConsumerState<DailyRemindersScreen> {
  final Set<int> _selectedReminderIds = <int>{};
  bool _isSelectionMode = false;

  bool get _selectionMode => _isSelectionMode;

  void _startSelectionMode() {
    setState(() => _isSelectionMode = true);
  }

  void _toggleSelection(int reminderId, bool selected) {
    setState(() {
      if (selected) {
        _selectedReminderIds.add(reminderId);
      } else {
        _selectedReminderIds.remove(reminderId);
      }
    });
  }

  void _enterSelection(int reminderId) {
    setState(() {
      _isSelectionMode = true;
      _selectedReminderIds.add(reminderId);
    });
  }

  void _clearSelection() {
    setState(() {
      _isSelectionMode = false;
      _selectedReminderIds.clear();
    });
  }

  Future<void> _deleteSelected(BuildContext context) async {
    final idsToDelete = _selectedReminderIds.toList(growable: false);
    for (final id in idsToDelete) {
      await ref
          .read(settingsProvider.notifier)
          .removeDailyReminder(reminderId: id);
    }
    if (mounted) {
      _clearSelection();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final settingsState = ref.watch(settingsProvider);
    final hasReminders = settingsState.maybeWhen(
      data: (settings) => settings.effectiveDailyReminders.isNotEmpty,
      orElse: () => false,
    );
    final hasSelection = _selectedReminderIds.isNotEmpty;
    if (!hasReminders && _selectionMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _clearSelection();
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsDailyReminders),
        actions: [
          if (_selectionMode || hasSelection)
            IconButton(
              tooltip: l10n.actionCancel,
              onPressed: _clearSelection,
              icon: const Icon(Icons.close),
            ),
          IconButton(
            tooltip: l10n.actionRemove,
            onPressed: !hasReminders
                ? null
                : (_selectionMode
                      ? (hasSelection ? () => _deleteSelected(context) : null)
                      : _startSelectionMode),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
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
                          label: l10n.dailyReminderTitle,
                          onTap: () async {
                            final reminderId = reminders[i].id;
                            if (_selectionMode) {
                              _toggleSelection(
                                reminderId,
                                !_selectedReminderIds.contains(reminderId),
                              );
                              return;
                            }
                            await _pickReminderTime(
                              context,
                              ref,
                              reminderId: reminderId,
                              current: reminders[i].time,
                            );
                          },
                          onChanged: (enabled) => unawaited(
                            ref
                                .read(settingsProvider.notifier)
                                .toggleDailyReminder(
                                  reminderId: reminders[i].id,
                                  enabled: enabled,
                                ),
                          ),
                          onLongPress: () => _enterSelection(reminders[i].id),
                          selectionMode: _selectionMode,
                          selected: _selectedReminderIds.contains(
                            reminders[i].id,
                          ),
                          onSelectionChanged: (selected) =>
                              _toggleSelection(reminders[i].id, selected),
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
              if (_selectionMode && _selectedReminderIds.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.sm),
                  child: AppInlineNotice(
                    icon: Icons.info_outline,
                    message: l10n.settingsDailyRemindersEmpty,
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
