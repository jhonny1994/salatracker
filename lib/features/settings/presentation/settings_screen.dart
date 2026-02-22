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
                        ListTile(
                          leading: const Icon(Icons.brightness_6),
                          title: Text(l10n.settingsTheme),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: AppSpacing.md),
                            child: SegmentedButton<AppThemeMode>(
                              segments: AppThemeMode.values.map((mode) {
                                return ButtonSegment<AppThemeMode>(
                                  value: mode,
                                  label: Text(_getThemeLabel(mode, l10n)),
                                );
                              }).toList(),
                              selected: <AppThemeMode>{settings.themeMode},
                              onSelectionChanged:
                                  (Set<AppThemeMode> newSelection) {
                                    unawaited(
                                      ref
                                          .read(settingsProvider.notifier)
                                          .updateThemeMode(newSelection.first),
                                    );
                                  },
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          indent: AppTouchTargets.comfortable,
                        ),
                        ListTile(
                          leading: const Icon(Icons.date_range),
                          title: Text(l10n.settingsWeekStart),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: AppSpacing.md),
                            child: SegmentedButton<int>(
                              segments: [
                                ButtonSegment<int>(
                                  value: DateTime.saturday,
                                  label: Text(l10n.weekStartSaturday),
                                ),
                                ButtonSegment<int>(
                                  value: DateTime.sunday,
                                  label: Text(l10n.weekStartSunday),
                                ),
                                ButtonSegment<int>(
                                  value: DateTime.monday,
                                  label: Text(l10n.weekStartMonday),
                                ),
                              ],
                              selected: <int>{settings.weekStart},
                              onSelectionChanged: (Set<int> newSelection) {
                                unawaited(
                                  ref
                                      .read(settingsProvider.notifier)
                                      .updateWeekStart(newSelection.first),
                                );
                              },
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          indent: AppTouchTargets.comfortable,
                        ),
                        ListTile(
                          leading: const Icon(Icons.language),
                          title: Text(l10n.settingsLanguage),
                          trailing: DropdownMenu<String>(
                            initialSelection:
                                settings.localeCode ??
                                Localizations.localeOf(context).languageCode,
                            onSelected: (String? code) {
                              if (code != null) {
                                unawaited(
                                  ref
                                      .read(settingsProvider.notifier)
                                      .updateLanguageCode(code),
                                );
                              }
                            },
                            dropdownMenuEntries: supportedLocales
                                .map<DropdownMenuEntry<String>>((
                                  Locale locale,
                                ) {
                                  return DropdownMenuEntry<String>(
                                    value: locale.languageCode,
                                    label: localizedLanguageName(
                                      context,
                                      locale,
                                    ),
                                  );
                                })
                                .toList(),
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
                          icon: Icons.lock_outline,
                          title: l10n.settingsAppLock,
                          subtitle: l10n.settingsAppLockSubtitle,
                          value: settings.appLockEnabled,
                          onChanged: (value) async {
                            if (value) {
                              final pin = await showDialog<String>(
                                context: context,
                                builder: (_) => const PinSetupDialog(),
                              );
                              if (pin == null) {
                                return;
                              }

                              final securityRepository = ref.read(
                                securityRepositoryProvider,
                              );
                              await securityRepository.setPin(pin);
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
                        ),
                        if (settings.appLockEnabled) ...[
                          const Divider(
                            height: 1,
                            indent: AppTouchTargets.comfortable,
                          ),
                          SettingsSwitchTile(
                            icon: Icons.fingerprint,
                            title: l10n.settingsBiometricUnlock,
                            subtitle:
                                (biometricsAvailableAsync.asData?.value ??
                                    false)
                                ? l10n.settingsBiometricUnlockSubtitle
                                : l10n.settingsBiometricUnlockUnavailable,
                            value: settings.biometricUnlockEnabled,
                            onChanged:
                                (biometricsAvailableAsync.asData?.value ??
                                    false)
                                ? (value) => ref
                                      .read(settingsProvider.notifier)
                                      .updateBiometricUnlockEnabled(
                                        enabled: value,
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

                              if (!context.mounted) {
                                return;
                              }

                              final newPin = await showDialog<String>(
                                context: context,
                                builder: (_) => const PinSetupDialog(),
                              );
                              if (newPin == null) {
                                return;
                              }

                              await securityRepository.setPin(newPin);
                            },
                          ),
                        ],
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
