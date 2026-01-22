import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/settings/presentation/prayer_schedule_screen.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Main settings screen allowing users to configure theme, language, and
/// application preferences.
///
/// Follows the "Settings" pattern with grouped sections and platform-adaptive
/// controls where appropriate.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final settingsState = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navSettings),
      ),
      body: settingsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => SettingsErrorState(l10n: l10n),
        data: (settings) => ListView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          children: [
            // Theme Section
            Text(
              l10n.settingsAppearance,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const Gap(AppSpacing.md),
            Card(
              child: Column(
                children: [
                  SettingsTile(
                    icon: Icons.brightness_6,
                    title: l10n.settingsTheme,
                    subtitle: _getThemeLabel(settings.themeMode, l10n),
                    onTap: () => _showThemePicker(
                      context,
                      ref,
                      settings.themeMode,
                      l10n,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    indent: AppTouchTargets.comfortable,
                  ),
                  SettingsTile(
                    icon: Icons.date_range,
                    title: l10n.settingsWeekStart,
                    subtitle: _getWeekStartLabel(settings.weekStart, l10n),
                    onTap: () => _showWeekStartPicker(
                      context,
                      ref,
                      settings.weekStart,
                      l10n,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    indent: AppTouchTargets.comfortable,
                  ),
                  SettingsTile(
                    icon: Icons.language,
                    title: l10n.settingsLanguage,
                    subtitle: _getLanguageLabel(settings.localeCode, l10n),
                    onTap: () => _showLanguagePicker(
                      context,
                      ref,
                      settings.localeCode,
                      l10n,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.xxl),

            // Preferences Section
            Text(
              l10n.settingsPreferences,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const Gap(AppSpacing.md),
            Card(
              child: Column(
                children: [
                  SettingsTile(
                    icon: Icons.access_time_filled,
                    title: l10n.settingsPrayerSchedule,
                    subtitle: l10n.settingsPrayerScheduleSubtitle,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const PrayerScheduleScreen(),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    indent: AppTouchTargets.comfortable,
                  ),
                  SettingsSwitchTile(
                    icon: Icons.notifications_active_outlined,
                    title: l10n.settingsNotifications,
                    subtitle: l10n.settingsNotificationsSubtitle,
                    value: settings.notificationsEnabled,
                    onChanged: (value) => ref
                        .read(settingsProvider.notifier)
                        .toggleNotifications(enabled: value),
                  ),
                  const Divider(
                    height: 1,
                    indent: AppTouchTargets.comfortable,
                  ),
                  SettingsSwitchTile(
                    icon: Icons.vibration,
                    title: l10n.settingsHaptics,
                    subtitle: l10n.settingsHapticsSubtitle,
                    value: settings.hapticsEnabled,
                    onChanged: (value) => ref
                        .read(settingsProvider.notifier)
                        .updateHaptics(enabled: value),
                  ),
                  const Divider(
                    height: 1,
                    indent: AppTouchTargets.comfortable,
                  ),
                  SettingsSwitchTile(
                    icon: Icons.star_outline,
                    title: l10n.settingsShowPoints,
                    subtitle: l10n.settingsShowPointsSubtitle,
                    value: settings.pointsVisible,
                    onChanged: (value) => ref
                        .read(settingsProvider.notifier)
                        .updateShowPoints(show: value),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.xxl),

            // About Section
            Text(
              l10n.settingsAbout,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const Gap(AppSpacing.md),
            Card(
              child: Column(
                children: [
                  SettingsTile(
                    icon: Icons.info_outline,
                    title: l10n.settingsAppVersion,
                    subtitle: '1.0.0',
                    trailing: const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeLabel(AppThemeMode mode, S l10n) {
    return switch (mode) {
      AppThemeMode.light => l10n.settingsThemeLight,
      AppThemeMode.dark => l10n.settingsThemeDark,
      AppThemeMode.system => l10n.settingsThemeSystem,
    };
  }

  String _getLanguageLabel(String? code, S l10n) {
    return switch (code) {
      'fr' => l10n.settingsLanguageFrench,
      _ => l10n.settingsLanguageEnglish,
    };
  }

  String _getWeekStartLabel(int weekday, S l10n) {
    return switch (weekday) {
      DateTime.sunday => l10n.weekStartSunday,
      DateTime.monday => l10n.weekStartMonday,
      DateTime.saturday => l10n.weekStartSaturday,
      _ => l10n.weekStartSunday,
    };
  }

  void _showThemePicker(
    BuildContext context,
    WidgetRef ref,
    AppThemeMode current,
    S l10n,
  ) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => ThemeSelectionSheet(currentMode: current),
      ),
    );
  }

  void _showWeekStartPicker(
    BuildContext context,
    WidgetRef ref,
    int current,
    S l10n,
  ) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => WeekStartSelectionSheet(currentStart: current),
      ),
    );
  }

  void _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    String? current,
    S l10n,
  ) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => LanguageSelectionSheet(currentCode: current),
      ),
    );
  }
}
