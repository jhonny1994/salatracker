import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:salat_tracker/core/localization/gen/generated/l10n.dart' as generated;

class AppLocalizationDelegate {
  static final localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    generated.S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
