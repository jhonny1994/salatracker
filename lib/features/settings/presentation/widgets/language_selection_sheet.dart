import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/settings/settings.dart';

/// Modal bottom sheet for selecting app language.
class LanguageSelectionSheet extends ConsumerWidget {
  /// Creates a [LanguageSelectionSheet].
  const LanguageSelectionSheet({
    required this.currentCode,
    super.key,
  });

  /// Currently selected language code.
  final String? currentCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);
    final languages = {
      'en': l10n.settingsLanguageEnglish,
      'ar': l10n.settingsLanguageArabic,
      'fr': l10n.settingsLanguageFrench,
    };

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: languages.entries.map((entry) {
          return ListTile(
            leading: Icon(
              entry.key == currentCode ? Icons.check : null,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(entry.value),
            onTap: () async {
              await ref
                  .read(settingsProvider.notifier)
                  .updateLanguageCode(entry.key)
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
}
