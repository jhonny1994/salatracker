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
    final currentLocale = currentCode == null
        ? Localizations.localeOf(context)
        : Locale(currentCode!);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: supportedLocales.map((locale) {
          final languageCode = locale.languageCode;
          return ListTile(
            leading: Icon(
              languageCode == currentLocale.languageCode ? Icons.check : null,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(localizedLanguageName(context, locale)),
            onTap: () async {
              await ref
                  .read(settingsProvider.notifier)
                  .updateLanguageCode(languageCode)
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
