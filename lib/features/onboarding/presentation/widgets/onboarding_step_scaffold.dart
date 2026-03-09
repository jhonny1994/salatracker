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
    this.isBusy = false,
    this.busyLabel,
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
  final bool isBusy;
  final String? busyLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final contentHeight = constraints.maxHeight * 0.45;

        return Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                      if (content case final contentWidget?) ...[
                        const Gap(AppSpacing.xl),
                        SizedBox(
                          height: contentHeight,
                          child: contentWidget,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const Gap(AppSpacing.lg),
              FilledButton(
                onPressed: isBusy ? null : onPrimary,
                child: isBusy
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox.square(
                            dimension: AppIconSizes.md,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                          const Gap(AppSpacing.sm),
                          Text(busyLabel ?? primaryLabel),
                        ],
                      )
                    : Text(primaryLabel),
              ),
              if (secondaryLabel != null && onSecondary != null) ...[
                const Gap(AppSpacing.sm),
                TextButton(
                  onPressed: isBusy ? null : onSecondary,
                  child: Text(secondaryLabel!),
                ),
              ],
              if (backLabel != null && onBack != null) ...[
                const Gap(AppSpacing.sm),
                TextButton(
                  onPressed: isBusy ? null : onBack,
                  child: Text(backLabel!),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
