import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/localization/gen/generated/l10n.dart';
import 'package:salat_tracker/core/theme/app_theme.dart';
import 'package:salat_tracker/features/prayer/data/providers/prayer_providers.dart';
import 'package:salat_tracker/features/prayer/domain/models/prayer_day.dart';
import 'package:salat_tracker/features/prayer/domain/models/prayer_type.dart';
import 'package:salat_tracker/features/today/application/today_controller.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayState = ref.watch(todayControllerProvider);
    final l10n = S.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: todayState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Error: $error'),
          ),
          data: (prayerDay) {
            final completedCount = prayerDay.entries
                .where((e) => e.isCompleted)
                .length;
            final totalPrayers = PrayerType.values.length;
            final completionPercentage = completedCount / totalPrayers;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Progress Card
                        _ProgressCard(
                          completedCount: completedCount,
                          totalPrayers: totalPrayers,
                          completionPercentage: completionPercentage,
                          points: prayerDay.points,
                        ),
                        const SizedBox(height: 24),
                        // Streak display
                        _StreakCard(),
                        const SizedBox(height: 24),
                        // Section title
                        Text(
                          l10n.navToday,
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                // Prayer list
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList.builder(
                    itemCount: PrayerType.values.length,
                    itemBuilder: (context, index) {
                      final type = PrayerType.values[index];
                      final isLogged = prayerDay.entries.any(
                        (e) => e.type == type && e.isCompleted,
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _PrayerTile(
                          type: type,
                          isLogged: isLogged,
                          onTap: () => ref
                              .read(todayControllerProvider.notifier)
                              .togglePrayer(type),
                        ),
                      );
                    },
                  ),
                ),
                // Encouragement message
                if (completionPercentage < 1.0)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        l10n.todayEncouragement,
                        style: theme.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                // Celebration message
                if (completionPercentage == 1.0)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Card(
                        color: theme
                            .extension<StatusChipTheme>()
                            ?.completeBackground,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.celebration_outlined,
                                color: theme
                                    .extension<StatusChipTheme>()
                                    ?.completeForeground,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                l10n.todayComplete,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme
                                      .extension<StatusChipTheme>()
                                      ?.completeForeground,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.completedCount,
    required this.totalPrayers,
    required this.completionPercentage,
    required this.points,
  });

  final int completedCount;
  final int totalPrayers;
  final double completionPercentage;
  final int points;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final statusMessage = switch (completedCount) {
      0 => l10n.todayNone,
      5 => l10n.todayComplete,
      _ => l10n.todayPartial(completedCount),
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.todayProgress,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            // Circular progress with percentage
            Center(
              child: SizedBox(
                width: 140,
                height: 140,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: completionPercentage,
                        strokeWidth: 10,
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation(
                          completionPercentage == 1.0
                              ? theme.colorScheme.tertiary
                              : theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(completionPercentage * 100).round()}%',
                          style: theme.textTheme.displaySmall,
                        ),
                        Text(
                          '$completedCount/$totalPrayers',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                statusMessage,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            if (points > 0) ...[
              const SizedBox(height: 8),
              Center(
                child: Chip(
                  avatar: Icon(
                    Icons.star_rounded,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                  label: Text(l10n.todayPoints(points)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StreakCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakCalculator = ref.watch(streakCalculatorProvider);
    final repository = ref.watch(prayerRepositoryProvider);
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return StreamBuilder<List<PrayerDay>>(
      stream: repository.watchDays(),
      builder: (context, snapshot) {
        final days = snapshot.data ?? [];
        final streak = streakCalculator.currentStreak(days);

        if (streak == 0) {
          return const SizedBox.shrink();
        }

        return Card(
          color: theme.colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Icon(
                  Icons.local_fire_department_rounded,
                  color: theme.colorScheme.onPrimaryContainer,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.todayStreak(streak),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isLogged
                      ? statusChipTheme?.completeForeground
                      : theme.colorScheme.surfaceContainerHighest,
                ),
                child: isLogged
                    ? Icon(
                        Icons.check_rounded,
                        size: 20,
                        color: statusChipTheme?.completeBackground,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  prayerName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isLogged
                        ? statusChipTheme?.completeForeground
                        : theme.colorScheme.onSurface,
                  ),
                ),
              ),
              if (!isLogged)
                Text(
                  l10n.tapToLog,
                  style: theme.textTheme.bodyMedium,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
