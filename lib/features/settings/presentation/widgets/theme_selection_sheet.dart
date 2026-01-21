import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/settings/settings.dart';

class ThemeSelectionSheet extends ConsumerWidget {
  const ThemeSelectionSheet({
    required this.currentMode,
    super.key,
  });

  final AppThemeMode currentMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: AppThemeMode.values.map((mode) {
          return ListTile(
            leading: Icon(
              mode == currentMode ? Icons.check : null,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(_getThemeLabel(mode, l10n)),
            onTap: () async {
              await ref
                  .read(settingsProvider.notifier)
                  .updateThemeMode(mode)
                  .then((_) {
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  });
            },
          );
        }).toList(),
      ),
    );
  }

  String _getThemeLabel(AppThemeMode mode, S l10n) {
    return switch (mode) {
      AppThemeMode.light => l10n.settingsThemeLight,
      AppThemeMode.dark => l10n.settingsThemeDark,
      AppThemeMode.system => l10n.settingsThemeSystem,
    };
  }
}
