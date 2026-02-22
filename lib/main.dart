import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/security/security.dart';
import 'package:salat_tracker/features/settings/settings.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Application entry point.
///
/// Initializes core services (Storage, Sentry, Notifications) and runs the
/// main [SalatTrackerApp] widget.
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
    appRunner: () async {
      // Initialize Notifications
      final container = ProviderContainer();
      try {
        await container.read(notificationServiceProvider).initialize();
      } on Object catch (e, stack) {
        // Error logging handled by Sentry
        await Sentry.captureException(e, stackTrace: stack);
      }

      runApp(
        UncontrolledProviderScope(
          container: container,
          child: const SalatTrackerApp(),
        ),
      );
    },
  );
}

class SalatTrackerApp extends ConsumerWidget {
  const SalatTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final settings = settingsAsync.value;
    final themeMode =
        settings?.themeMode.toFlutterThemeMode() ?? ThemeMode.system;
    final localeCode = settings?.localeCode;

    final router = ref.watch(appRouterProvider);

    return AppLockLifecycleGate(
      child: DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) {
          return MaterialApp.router(
            theme: AppTheme.light(dynamicScheme: lightDynamic),
            darkTheme: AppTheme.dark(dynamicScheme: darkDynamic),
            themeMode: themeMode,
            routerConfig: router,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
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
        },
      ),
    );
  }
}
