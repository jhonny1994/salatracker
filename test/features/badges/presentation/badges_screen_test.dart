import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/badges/badges.dart';

void main() {
  testWidgets('shows empty state when no badges', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          badgesProvider.overrideWith((ref) => Stream.value(const [])),
        ],
        child: _testApp(const BadgesScreen()),
      ),
    );

    await tester.pump();
    expect(find.byType(BadgesScreen), findsOneWidget);
  });

  testWidgets('shows badge tile when data exists', (tester) async {
    final award = BadgeAward(
      type: BadgeType.firstPrayerLogged,
      earnedAt: DateTime(2026),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          badgesProvider.overrideWith((ref) => Stream.value([award])),
        ],
        child: _testApp(const BadgesScreen()),
      ),
    );

    await tester.pump();
    expect(find.byType(BadgeTile), findsOneWidget);
  });
}

Widget _testApp(Widget child) {
  return MaterialApp(
    home: child,
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: supportedLocales,
  );
}
