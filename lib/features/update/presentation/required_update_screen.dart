import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/update/update.dart';
import 'package:salat_tracker/shared/shared.dart';

class RequiredUpdateScreen extends ConsumerWidget {
  const RequiredUpdateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final updateState = ref.watch(updateProvider);

    return Scaffold(
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: AppAsyncValue(
              value: updateState,
              data: (decision) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.system_update_outlined,
                      size: AppIconSizes.display,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      decision.status == UpdateStatus.requiredGrace
                          ? l10n.updateRequiredGrace
                          : l10n.updateRequiredBlocked,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(decision.message, textAlign: TextAlign.center),
                    const SizedBox(height: AppSpacing.xl),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => ref
                            .read(updateProvider.notifier)
                            .performPrimaryAction(),
                        child: Text(l10n.updateActionNow),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
