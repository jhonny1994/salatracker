import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:salat_tracker/shared/shared.dart';

class LocationContextBanner extends ConsumerWidget {
  const LocationContextBanner({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
  });

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final locationState = ref.watch(locationContextNotifierProvider);
    final theme = Theme.of(context);

    final subtitle = locationState.when(
      data: (value) => value.displayLabel,
      loading: () => '...',
      error: (_, _) => l10n.settingsCurrentTimezoneUnavailable,
    );

    return Padding(
      padding: padding,
      child: AppSurfaceCard(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Icon(Icons.place_outlined, color: theme.colorScheme.primary),
            const Gap(AppSpacing.sm),
            Expanded(
              child: Text(
                '${l10n.settingsCurrentTimezone}: $subtitle',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            IconButton(
              tooltip: l10n.errorRetry,
              onPressed: () =>
                  ref.read(locationContextNotifierProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}
