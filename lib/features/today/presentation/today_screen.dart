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

/// Main dashboard screen showing today's prayer progress and timeline.
///
/// Handles the "Gamification" aspect with completion states,
/// while delegating specific UI components to specialized widgets.
class TodayScreen extends ConsumerStatefulWidget {
  const TodayScreen({super.key});

  @override
  ConsumerState<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends ConsumerState<TodayScreen> {
  bool _hasCelebrated = false;

  @override
  Widget build(BuildContext context) {
    final todayState = ref.watch(todayControllerProvider);
    final l10n = S.of(context);
    final settings = ref.watch(settingsProvider).asData?.value;

    ref.listen(todayControllerProvider, (previous, next) {
      if (next case AsyncData(value: final prayerDay)) {
        final completedCount = prayerDay.entries
            .where((e) => e.isCompleted)
            .length;
        final totalPrayers = PrayerType.values.length;
        final isComplete = completedCount == totalPrayers;

        if (isComplete && !_hasCelebrated) {
          if (settings?.hapticsEnabled ?? true) {
            unawaited(HapticFeedback.mediumImpact());
          }
          setState(() => _hasCelebrated = true);
        } else if (!isComplete) {
          _hasCelebrated = false;
        }
      }
    });

    return Scaffold(
      body: SafeArea(
        child: todayState.when(
          loading: () => const TodayLoadingState(),
          error: (error, stack) => TodayErrorState(
            onRetry: () => ref.invalidate(todayControllerProvider),
          ),
          data: (prayerDay) {
            final completedCount = prayerDay.entries
                .where((e) => e.isCompleted)
                .length;
            final totalPrayers = PrayerType.values.length;
            final completionPercentage = completedCount / totalPrayers;
            final encouragementMessage = _buildEncouragementMessage(
              l10n,
              completedCount,
              totalPrayers,
            );

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(todayControllerProvider);
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const LocationContextBanner(
                            padding: EdgeInsets.zero,
                          ),
                          const Gap(AppSpacing.lg),
                          TodayProgressCard(
                                completedCount: completedCount,
                                totalPrayers: totalPrayers,
                                completionPercentage: completionPercentage,
                                points: prayerDay.points,
                              )
                              .animate()
                              .fadeIn(duration: AppDurations.smooth)
                              .slideY(
                                begin: 0.1,
                                end: 0,
                                duration: AppDurations.smooth,
                                curve: Curves.easeOut,
                              ),
                          const Gap(AppSpacing.lg),
                          const TodayStreakCard(),
                          const Gap(AppSpacing.lg),
                          AppSectionHeader(
                            title: l10n.navToday,
                            subtitle: encouragementMessage,
                          ),
                          const Gap(AppSpacing.md),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                    ),
                    sliver: SliverList.builder(
                      itemCount: PrayerType.values.length,
                      itemBuilder: (context, index) {
                        final type = PrayerType.values[index];
                        final isLogged = prayerDay.entries.any(
                          (e) => e.type == type && e.isCompleted,
                        );
                        return PrayerListItem(
                          key: ValueKey('prayer_${type.name}'),
                          type: type,
                          isLogged: isLogged,
                          index: index,
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: completionPercentage == 1.0
                          ? const TodayCelebrationCard()
                          : const SizedBox.shrink(),
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: AppSpacing.xxl),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _buildEncouragementMessage(
    S l10n,
    int completedCount,
    int totalPrayers,
  ) {
    if (completedCount == 0) {
      return l10n.todayNone;
    }
    if (completedCount >= totalPrayers) {
      return l10n.todayComplete;
    }
    return l10n.todayPartial(completedCount);
  }
}
