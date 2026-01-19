import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    return const MaterialApp(
      title: 'Salat Tracker',
      home: Scaffold(
        body: Center(
          child: Text('Salat Tracker'),
        ),
      ),
    );
  }
}
