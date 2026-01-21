import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

class TodayErrorState extends ConsumerWidget {
  const TodayErrorState({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = S.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppIconSizes.hero,
              color: theme.colorScheme.error,
            ),
            const Gap(AppSpacing.lg),
            Text(
              l10n.errorLoadingData,
              style: theme.textTheme.titleMedium,
            ),
            const Gap(AppSpacing.xxl),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.errorRetry),
            ),
          ],
        ),
      ),
    );
  }
}
