import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/security/security.dart';

void main() {
  testWidgets('accepts digits and triggers completion', (tester) async {
    String? result;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PinPad(
            length: 4,
            onCompleted: (value) => result = value,
          ),
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('3'));
    await tester.tap(find.text('4'));
    await tester.pump();

    expect(result, '1234');
  });

  testWidgets('blocks input when disabled', (tester) async {
    String? result;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PinPad(
            length: 4,
            enabled: false,
            onCompleted: (value) => result = value,
          ),
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('3'));
    await tester.tap(find.text('4'));
    await tester.pump();

    expect(result, isNull);
  });
}
