import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/badges/data/providers/providers.dart';
import 'package:salat_tracker/features/badges/presentation/widgets/widgets.dart';
import 'package:salat_tracker/shared/shared.dart';

class BadgesScreen extends ConsumerWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final awardsAsync = ref.watch(badgesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.badgesTitle),
      ),
      body: awardsAsync.when(
        data: (awards) {
          if (awards.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Text(
                  l10n.badgesEmpty,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemBuilder: (context, index) => BadgeTile(award: awards[index]),
            separatorBuilder: (context, index) => const Gap(AppSpacing.sm),
            itemCount: awards.length,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Text(
              l10n.errorLoadingData,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
