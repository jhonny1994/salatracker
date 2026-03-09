import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/onboarding/onboarding.dart';

void main() {
  testWidgets('disables actions and shows busy label when loading', (
    tester,
  ) async {
    var primaryTapped = false;
    var secondaryTapped = false;
    var backTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OnboardingStepScaffold(
            icon: Icons.check,
            title: 'Title',
            body: 'Body',
            primaryLabel: 'Continue',
            onPrimary: () => primaryTapped = true,
            secondaryLabel: 'Later',
            onSecondary: () => secondaryTapped = true,
            backLabel: 'Back',
            onBack: () => backTapped = true,
            isBusy: true,
            busyLabel: 'Saving...',
          ),
        ),
      ),
    );

    expect(find.text('Saving...'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.tap(find.text('Saving...'));
    await tester.tap(find.text('Later'));
    await tester.tap(find.text('Back'));
    await tester.pump();

    expect(primaryTapped, isFalse);
    expect(secondaryTapped, isFalse);
    expect(backTapped, isFalse);
  });
}
