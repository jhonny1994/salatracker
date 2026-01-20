import 'package:flutter/widgets.dart';
import 'package:locale_names/locale_names.dart';

String localizedLanguageName(BuildContext context, Locale locale) {
  final currentLocale = Localizations.localeOf(context);
  final name = locale.displayLanguageIn(currentLocale);
  return name.isEmpty ? locale.languageCode : name;
}
