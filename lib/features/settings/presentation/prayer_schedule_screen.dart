import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Prayer schedule configuration screen.
///
/// Allows users to set custom prayer times and notification offsets for
/// each of the five daily prayers.
class PrayerScheduleScreen extends ConsumerWidget {
  /// Creates a [PrayerScheduleScreen].
  const PrayerScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final settingsState = ref.watch(settingsProvider);
    final locationState = ref.watch(locationContextNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsPrayerSchedule),
      ),
      body: settingsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => SettingsErrorState(l10n: l10n),
        data: (settings) {
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.xl),
            itemCount: PrayerType.values.length + 1,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              if (index == 0) {
                final timezoneLabel = locationState.when(
                  data: (value) => value.displayLabel,
                  loading: () => '...',
                  error: (_, _) => l10n.settingsCurrentTimezoneUnavailable,
                );

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.public_outlined),
                  title: Text(
                    l10n.settingsCurrentTimezone,
                    style: theme.textTheme.titleMedium,
                  ),
                  subtitle: Text(timezoneLabel),
                );
              }

              final type = PrayerType.values[index - 1];
              final time =
                  settings.prayerTimes[type] ??
                  const TimeOfDay(hour: 0, minute: 0);

              return ListTile(
                title: Text(
                  _getPrayerName(type, l10n),
                  style: theme.textTheme.titleMedium,
                ),
                trailing: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.end,
                  spacing: AppSpacing.sm,
                  children: [
                    if (settings.offsets[type] != 0)
                      Text(
                        l10n.offsetMinutes(settings.offsets[type] ?? 0),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    IconButton(
                      icon: const Icon(Icons.alarm),
                      tooltip: l10n.settingsReminderOffset,
                      onPressed: () => _pickOffset(
                        context,
                        ref,
                        type,
                        settings.offsets[type] ?? 0,
                      ),
                    ),
                    AppStatusBadge(
                      label: time.format(context),
                      isPill: false,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      foregroundColor: theme.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
                onTap: () => _pickTime(context, ref, type, time),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _pickTime(
    BuildContext context,
    WidgetRef ref,
    PrayerType type,
    TimeOfDay current,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: current,
    );

    if (picked != null) {
      await ref
          .read(settingsProvider.notifier)
          .updatePrayerTime(type: type, time: picked);
    }
  }

  Future<void> _pickOffset(
    BuildContext context,
    WidgetRef ref,
    PrayerType type,
    int currentOffset,
  ) async {
    final l10n = S.of(context);
    // Simple dialog with preset offsets for now, or a slider?
    // Let's use a dialog with a slider for granularity.
    final picked = await showDialog<int>(
      context: context,
      builder: (context) => OffsetPickerDialog(
        initialValue: currentOffset,
        title: _getPrayerName(type, l10n),
      ),
    );

    if (picked != null) {
      await ref
          .read(settingsProvider.notifier)
          .updatePrayerOffset(type: type, offsetMinutes: picked);
    }
  }

  String _getPrayerName(PrayerType type, S l10n) {
    return switch (type) {
      PrayerType.fajr => l10n.prayerFajr,
      PrayerType.dhuhr => l10n.prayerDhuhr,
      PrayerType.asr => l10n.prayerAsr,
      PrayerType.maghrib => l10n.prayerMaghrib,
      PrayerType.isha => l10n.prayerIsha,
    };
  }
}
