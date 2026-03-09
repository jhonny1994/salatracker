import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/shared/shared.dart';

void main() {
  group('AppAsyncValue', () {
    testWidgets('renders default loading state', (tester) async {
      await _pumpAsyncValue(
        tester,
        value: const AsyncLoading<int>(),
        data: (value) => Text('$value'),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders default error state with retry action', (
      tester,
    ) async {
      var retried = false;

      await _pumpAsyncValue(
        tester,
        value: AsyncError<int>(Exception('boom'), StackTrace.empty),
        retry: () => retried = true,
        data: (value) => Text('$value'),
      );

      expect(find.text('Error loading data'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      await tester.tap(find.text('Retry'));
      await tester.pump();

      expect(retried, isTrue);
    });

    testWidgets('renders data state', (tester) async {
      await _pumpAsyncValue(
        tester,
        value: const AsyncData<int>(42),
        data: (value) => Text('Value: $value'),
      );

      expect(find.text('Value: 42'), findsOneWidget);
    });
  });
}

Future<void> _pumpAsyncValue<T>(
  WidgetTester tester, {
  required AsyncValue<T> value,
  required Widget Function(T data) data,
  VoidCallback? retry,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(
        body: AppAsyncValue<T>(
          value: value,
          retry: retry,
          data: data,
        ),
      ),
    ),
  );

  await tester.pump();
}
