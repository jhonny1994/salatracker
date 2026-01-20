import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/core/localization/gen/generated/l10n.dart' show S;
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await HiveService.initialize();

  await SentryFlutter.init(
    (options) {
      options
        ..dsn = dotenv.env['SENTRY_DSN']
        ..sendDefaultPii = false
        ..environment = dotenv.env['SENTRY_ENV'] ?? 'development';
    },
    appRunner: () => runApp(
      const ProviderScope(
        child: SalatTrackerApp(),
      ),
    ),
  );
}

class SalatTrackerApp extends ConsumerWidget {
  const SalatTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsControllerProvider);
    final settings = settingsAsync.value;
    final themeMode =
        settings?.themeMode.toFlutterThemeMode() ?? ThemeMode.system;
    final localeCode = settings?.localeCode;

    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: router,
      localizationsDelegates: AppLocalizationDelegate.localizationsDelegates,
      supportedLocales: supportedLocales,
      locale: localeCode == null ? null : Locale(localeCode),
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
