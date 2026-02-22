import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/badges/domain/models/models.dart';
import 'package:salat_tracker/shared/shared.dart';

class BadgeTile extends StatelessWidget {
  const BadgeTile({required this.award, super.key});

  final BadgeAward award;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return AppSurfaceCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(
              _iconForType(award.type),
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _nameForType(award.type, l10n),
                  style: theme.textTheme.titleMedium,
                ),
                const Gap(AppSpacing.xs),
                Text(
                  _descriptionForType(award.type, l10n),
                  style: theme.textTheme.bodySmall,
                ),
                const Gap(AppSpacing.xs),
                Text(
                  l10n.badgesEarnedOn(award.earnedAt.toFormattedDate),
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForType(BadgeType type) {
    return switch (type) {
      BadgeType.firstPrayerLogged => Icons.check_circle_outline,
      BadgeType.weekConsistency => Icons.date_range,
      BadgeType.monthComplete => Icons.calendar_month,
      BadgeType.seasonChampion => Icons.emoji_events_outlined,
    };
  }

  String _nameForType(BadgeType type, S l10n) {
    return switch (type) {
      BadgeType.firstPrayerLogged => l10n.badgeFirstPrayerName,
      BadgeType.weekConsistency => l10n.badgeWeekConsistencyName,
      BadgeType.monthComplete => l10n.badgeMonthCompleteName,
      BadgeType.seasonChampion => l10n.badgeSeasonChampionName,
    };
  }

  String _descriptionForType(BadgeType type, S l10n) {
    return switch (type) {
      BadgeType.firstPrayerLogged => l10n.badgeFirstPrayerDescription,
      BadgeType.weekConsistency => l10n.badgeWeekConsistencyDescription,
      BadgeType.monthComplete => l10n.badgeMonthCompleteDescription,
      BadgeType.seasonChampion => l10n.badgeSeasonChampionDescription,
    };
  }
}
