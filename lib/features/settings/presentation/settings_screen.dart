import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/badges/badges.dart';
import 'package:salat_tracker/features/security/security.dart';
import 'package:salat_tracker/features/settings/data/providers/settings_providers.dart';
import 'package:salat_tracker/features/settings/domain/models/app_theme_mode.dart';
import 'package:salat_tracker/features/settings/presentation/prayer_schedule_screen.dart';
import 'package:salat_tracker/features/settings/presentation/widgets/widgets.dart';
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
    final biometricsAvailableAsync = ref.watch(biometricsAvailableProvider);

    return Scaffold(
      body: settingsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => SettingsErrorState(l10n: l10n),
        data: (settings) => CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: Text(l10n.navSettings),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              sliver: SliverList.list(
                children: [
                  const LocationContextBanner(
                    padding: EdgeInsets.zero,
                  ),
                  const Gap(AppSpacing.xl),
                  AppSectionHeader(title: l10n.settingsAppearance),
                  const Gap(AppSpacing.md),
                  AppSurfaceCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        SettingsTile(
                          icon: Icons.brightness_6,
                          title: l10n.settingsTheme,
                          subtitle: _getThemeLabel(settings.themeMode, l10n),
                          onTap: () => _showSelectionDialog<AppThemeMode>(
                            context,
                            title: l10n.settingsTheme,
                            value: settings.themeMode,
                            options: AppThemeMode.values,
                            labelBuilder: (mode) => _getThemeLabel(mode, l10n),
                            onChanged: (mode) => unawaited(
                              ref
                                  .read(settingsProvider.notifier)
                                  .updateThemeMode(mode),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          indent: AppTouchTargets.comfortable,
                        ),
                        SettingsTile(
                          icon: Icons.date_range,
                          title: l10n.settingsWeekStart,
                          subtitle: _getWeekStartLabel(
                            settings.weekStart,
                            l10n,
                          ),
                          onTap: () => _showSelectionDialog<int>(
                            context,
                            title: l10n.settingsWeekStart,
                            value: settings.weekStart,
                            options: [
                              DateTime.saturday,
                              DateTime.sunday,
                              DateTime.monday,
                            ],
                            labelBuilder: (day) =>
                                _getWeekStartLabel(day, l10n),
                            onChanged: (day) => unawaited(
                              ref
                                  .read(settingsProvider.notifier)
                                  .updateWeekStart(day),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          indent: AppTouchTargets.comfortable,
                        ),
                        SettingsTile(
                          icon: Icons.language,
                          title: l10n.settingsLanguage,
                          subtitle: localizedLanguageName(
                            context,
                            Locale(
                              settings.localeCode ??
                                  Localizations.localeOf(context).languageCode,
                            ),
                          ),
                          onTap: () => _showSelectionDialog<String>(
                            context,
                            title: l10n.settingsLanguage,
                            value:
                                settings.localeCode ??
                                Localizations.localeOf(context).languageCode,
                            options: supportedLocales
                                .map((l) => l.languageCode)
                                .toList(),
                            labelBuilder: (code) =>
                                localizedLanguageName(context, Locale(code)),
                            onChanged: (code) => unawaited(
                              ref
                                  .read(settingsProvider.notifier)
                                  .updateLanguageCode(code),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(AppSpacing.xxl),
                  AppSectionHeader(title: l10n.settingsPreferences),
                  const Gap(AppSpacing.md),
                  AppSurfaceCard(
                    padding: EdgeInsets.zero,
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
                        SettingsTile(
                          icon: Icons.emoji_events_outlined,
                          title: l10n.settingsBadges,
                          subtitle: l10n.settingsBadgesSubtitle,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const BadgesScreen(),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          indent: AppTouchTargets.comfortable,
                        ),
                        SettingsTile(
                          icon: Icons.notifications_active_outlined,
                          title: l10n.settingsNotifications,
                          subtitle: l10n.settingsNotificationsSubtitle,
                          trailing: _buildStatusLabel(
                            context,
                            settings.notificationsEnabled,
                            l10n,
                          ),
                          onTap: () => _showToggleDialog(
                            context,
                            title: l10n.settingsNotifications,
                            value: settings.notificationsEnabled,
                            onChanged: (value) => ref
                                .read(settingsProvider.notifier)
                                .toggleNotifications(enabled: value),
                            l10n: l10n,
                          ),
                        ),
                        const Divider(
                          height: 1,
                          indent: AppTouchTargets.comfortable,
                        ),
                        SettingsTile(
                          icon: Icons.lock_outline,
                          title: l10n.settingsAppLock,
                          subtitle: l10n.settingsAppLockSubtitle,
                          trailing: _buildStatusLabel(
                            context,
                            settings.appLockEnabled,
                            l10n,
                          ),
                          onTap: () => _showToggleDialog(
                            context,
                            title: l10n.settingsAppLock,
                            value: settings.appLockEnabled,
                            onChanged: (value) async {
                              if (value) {
                                final pin = await showDialog<String>(
                                  context: context,
                                  builder: (_) => const PinSetupDialog(),
                                );
                                if (pin == null) return;
                                await ref
                                    .read(securityRepositoryProvider)
                                    .setPin(pin);
                              }
                              await ref
                                  .read(settingsProvider.notifier)
                                  .updateAppLockEnabled(enabled: value);

                              if (!value) {
                                ref
                                    .read(appLockControllerProvider.notifier)
                                    .unlockApp();
                              }
                            },
                            l10n: l10n,
                          ),
                        ),
                        if (settings.appLockEnabled) ...[
                          const Divider(
                            height: 1,
                            indent: AppTouchTargets.comfortable,
                          ),
                          SettingsTile(
                            icon: Icons.fingerprint,
                            title: l10n.settingsBiometricUnlock,
                            subtitle:
                                (biometricsAvailableAsync.asData?.value ??
                                    false)
                                ? l10n.settingsBiometricUnlockSubtitle
                                : l10n.settingsBiometricUnlockUnavailable,
                            trailing: _buildStatusLabel(
                              context,
                              settings.biometricUnlockEnabled,
                              l10n,
                            ),
                            onTap:
                                (biometricsAvailableAsync.asData?.value ??
                                    false)
                                ? () => _showToggleDialog(
                                    context,
                                    title: l10n.settingsBiometricUnlock,
                                    value: settings.biometricUnlockEnabled,
                                    onChanged: (value) => ref
                                        .read(settingsProvider.notifier)
                                        .updateBiometricUnlockEnabled(
                                          enabled: value,
                                        ),
                                    l10n: l10n,
                                  )
                                : null,
                          ),
                          const Divider(
                            height: 1,
                            indent: AppTouchTargets.comfortable,
                          ),
                          SettingsTile(
                            icon: Icons.password_outlined,
                            title: l10n.settingsResetPin,
                            subtitle: l10n.settingsResetPinSubtitle,
                            onTap: () async {
                              final currentPin = await showDialog<String>(
                                context: context,
                                builder: (_) => const CurrentPinDialog(),
                              );
                              if (currentPin == null ||
                                  currentPin.length != 6) {
                                return;
                              }

                              final securityRepository = ref.read(
                                securityRepositoryProvider,
                              );
                              final valid = await securityRepository.verifyPin(
                                currentPin,
                              );
                              if (!valid) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        l10n.securityCurrentPinError,
                                      ),
                                    ),
                                  );
                                }
                                return;
                              }

                              if (!context.mounted) return;

                              final newPin = await showDialog<String>(
                                context: context,
                                builder: (_) => const PinSetupDialog(),
                              );
                              if (newPin == null) return;

                              await securityRepository.setPin(newPin);
                            },
                          ),
                        ],
                        const Divider(
                          height: 1,
                          indent: AppTouchTargets.comfortable,
                        ),
                        SettingsTile(
                          icon: Icons.vibration,
                          title: l10n.settingsHaptics,
                          subtitle: l10n.settingsHapticsSubtitle,
                          trailing: _buildStatusLabel(
                            context,
                            settings.hapticsEnabled,
                            l10n,
                          ),
                          onTap: () => _showToggleDialog(
                            context,
                            title: l10n.settingsHaptics,
                            value: settings.hapticsEnabled,
                            onChanged: (value) => ref
                                .read(settingsProvider.notifier)
                                .updateHaptics(enabled: value),
                            l10n: l10n,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(AppSpacing.xxl),
                  AppSectionHeader(title: l10n.settingsAbout),
                  const Gap(AppSpacing.md),
                  AppSurfaceCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        _buildVersionTile(l10n),
                      ],
                    ),
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

  String _getWeekStartLabel(int day, S l10n) {
    return switch (day) {
      DateTime.saturday => l10n.weekStartSaturday,
      DateTime.sunday => l10n.weekStartSunday,
      DateTime.monday => l10n.weekStartMonday,
      _ => '',
    };
  }

  /// Builds a pill-shaped status badge for boolean preferences.
  ///
  /// Backed by the shared [AppStatusBadge] to eliminate UI duplication.
  Widget _buildStatusLabel(BuildContext context, bool enabled, S l10n) {
    final theme = Theme.of(context);
    return AppStatusBadge(
      label: enabled ? l10n.generalYes : l10n.generalNo,
      backgroundColor: enabled
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.surfaceContainerHighest,
      foregroundColor: enabled
          ? theme.colorScheme.onPrimaryContainer
          : theme.colorScheme.onSurfaceVariant,
    );
  }

  /// Triggers a sleek [AlertDialog] to select from multiple options.
  void _showSelectionDialog<T>(
    BuildContext context, {
    required String title,
    required T value,
    required List<T> options,
    required String Function(T) labelBuilder,
    required ValueChanged<T> onChanged,
  }) {
    final theme = Theme.of(context);

    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: options.map((option) {
                  final isSelected = option == value;
                  return ListTile(
                    title: Text(labelBuilder(option)),
                    trailing: Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                    onTap: () {
                      onChanged(option);
                      Navigator.of(dialogContext).pop();
                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Triggers a sleek [AlertDialog] to toggle boolean preferences.
  ///
  /// This approach provides a cleaner alternative to generic trailing switches,
  /// enhancing the visual rhythm of the overall settings list.
  void _showToggleDialog(
    BuildContext context, {
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required S l10n,
  }) {
    final theme = Theme.of(context);

    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(l10n.generalYes),
                  trailing: Icon(
                    value
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: value
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  onTap: () {
                    onChanged(true);
                    Navigator.of(dialogContext).pop();
                  },
                ),
                ListTile(
                  title: Text(l10n.generalNo),
                  trailing: Icon(
                    !value
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: !value
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  onTap: () {
                    onChanged(false);
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildVersionTile(S l10n) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final info = snapshot.data;
        final subtitle = info == null
            ? l10n.settingsVersionLoading
            : '${info.version}+${info.buildNumber}';

        return SettingsTile(
          icon: Icons.info_outline,
          title: l10n.settingsAppVersion,
          subtitle: subtitle,
          trailing: const SizedBox.shrink(),
        );
      },
    );
  }
}
