import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salat_tracker/shared/shared.dart';

class OnboardingStepScaffold extends StatelessWidget {
  const OnboardingStepScaffold({
    required this.icon,
    required this.title,
    required this.body,
    required this.primaryLabel,
    required this.onPrimary,
    super.key,
    this.content,
    this.secondaryLabel,
    this.onSecondary,
    this.backLabel,
    this.onBack,
  });

  final IconData icon;
  final String title;
  final String body;
  final String primaryLabel;
  final VoidCallback? onPrimary;
  final Widget? content;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final String? backLabel;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          const Spacer(),
          Icon(
            icon,
            size: AppIconSizes.display,
            color: theme.colorScheme.primary,
          ),
          const Gap(AppSpacing.xl),
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(AppSpacing.md),
          Text(
            body,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          if (content != null) ...[
            const Gap(AppSpacing.xl),
            Expanded(child: content!),
          ] else
            const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onPrimary,
              child: Text(primaryLabel),
            ),
          ),
          if (secondaryLabel != null && onSecondary != null) ...[
            const Gap(AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onSecondary,
                child: Text(secondaryLabel!),
              ),
            ),
          ],
          if (backLabel != null && onBack != null) ...[
            const Gap(AppSpacing.sm),
            TextButton(
              onPressed: onBack,
              child: Text(backLabel!),
            ),
          ],
        ],
      ),
    );
  }
}
