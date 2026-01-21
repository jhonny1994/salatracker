import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/shared/shared.dart';
import 'package:shimmer/shimmer.dart';

class TodayLoadingState extends StatelessWidget {
  const TodayLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.surfaceContainerHighest,
      highlightColor: theme.colorScheme.surface,
      child: const Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            _ShimmerBox(height: 280),
            Gap(AppSpacing.xxl),
            _ShimmerBox(height: 72),
            Gap(AppSpacing.md),
            _ShimmerBox(height: 72),
            Gap(AppSpacing.md),
            _ShimmerBox(height: 72),
            Gap(AppSpacing.md),
            _ShimmerBox(height: 72),
            Gap(AppSpacing.md),
            _ShimmerBox(height: 72),
          ],
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    );
  }
}
