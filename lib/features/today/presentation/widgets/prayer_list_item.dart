import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/features/today/today.dart';
import 'package:salat_tracker/shared/shared.dart';

/// Extracted list item widget with const constructor for performance
class PrayerListItem extends ConsumerWidget {
  const PrayerListItem({
    required this.type,
    required this.isLogged,
    required this.index,
    super.key,
  });

  final PrayerType type;
  final bool isLogged;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: _PrayerTile(
            type: type,
            isLogged: isLogged,
            onTap: () {
              final settings = ref.read(settingsProvider).asData?.value;
              if (settings?.hapticsEnabled ?? true) {
                unawaited(HapticFeedback.lightImpact());
              }
              unawaited(
                ref.read(todayControllerProvider.notifier).togglePrayer(type),
              );
            },
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 50 * index),
          duration: const Duration(milliseconds: 250),
        )
        .slideX(
          begin: 0.1,
          end: 0,
          delay: Duration(milliseconds: 50 * index),
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
  }
}

class _PrayerTile extends StatelessWidget {
  const _PrayerTile({
    required this.type,
    required this.isLogged,
    required this.onTap,
  });

  final PrayerType type;
  final bool isLogged;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final statusChipTheme = theme.extension<StatusChipTheme>();

    final prayerName = switch (type) {
      PrayerType.fajr => l10n.prayerFajr,
      PrayerType.dhuhr => l10n.prayerDhuhr,
      PrayerType.asr => l10n.prayerAsr,
      PrayerType.maghrib => l10n.prayerMaghrib,
      PrayerType.isha => l10n.prayerIsha,
    };

    return Card(
      color: isLogged
          ? statusChipTheme?.completeBackground
          : theme.colorScheme.surface,
      elevation: isLogged ? AppElevations.none : AppElevations.low,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          child: SizedBox(
            height: AppTouchTargets.minimum,
            child: Row(
              children: [
                AnimatedContainer(
                  key: ValueKey('checkbox_${type.name}_$isLogged'),
                  duration: AppDurations.normal,
                  curve: Curves.easeOut,
                  width: AppTouchTargets.checkbox,
                  height: AppTouchTargets.checkbox,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isLogged
                        ? statusChipTheme?.completeForeground
                        : theme.colorScheme.surfaceContainerHighest,
                    border: isLogged
                        ? null
                        : Border.all(
                            color: theme.colorScheme.outline.withValues(
                              alpha: 0.3,
                            ),
                            width: 2,
                          ),
                  ),
                  child: AnimatedSwitcher(
                    duration: AppDurations.normal,
                    child: isLogged
                        ? Icon(
                            Icons.check_rounded,
                            key: const ValueKey('check'),
                            size: 22,
                            color: statusChipTheme?.completeBackground,
                          )
                        : const SizedBox.shrink(key: ValueKey('empty')),
                  ),
                ),
                const Gap(AppSpacing.lg),
                Expanded(
                  child: Text(
                    prayerName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: isLogged
                          ? statusChipTheme?.completeForeground
                          : theme.colorScheme.onSurface,
                      fontWeight: isLogged ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
                if (!isLogged)
                  Text(
                    l10n.tapToLog,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                if (isLogged)
                  Icon(
                    Icons.check_circle_rounded,
                    color: statusChipTheme?.completeForeground,
                    size: AppIconSizes.md,
                    // Use a slightly larger size for the check circle
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
