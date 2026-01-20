import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/core/localization/gen/generated/l10n.dart' show S;
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await SentryFlutter.init(
    (options) {
      options
        ..dsn = dotenv.env['SENTRY_DSN']
        ..sendDefaultPii = false
        ..environment = dotenv.env['SENTRY_ENV'] ?? 'development';
    },
    appRunner: () => runApp(const SalatTrackerApp()),
  );
}

class SalatTrackerApp extends StatelessWidget {
  const SalatTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Salat Tracker',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: appRouter,
      localizationsDelegates: AppLocalizationDelegate.localizationsDelegates,
      supportedLocales: supportedLocales,
      localeResolutionCallback: (locale, supported) {
        if (locale == null) {
          return const Locale('ar');
        }
        for (final supportedLocale in supported) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return const Locale('en');
      },
      onGenerateTitle: (context) => S.of(context).appTitle,
    );
  }
}
