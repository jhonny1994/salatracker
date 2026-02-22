import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/settings/presentation/widgets/settings_tile.dart';

void main() {
  testWidgets('uses chevron_right in RTL as forward affordance', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: SettingsTile(
              icon: Icons.settings,
              title: 'Settings',
            ),
          ),
        ),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is Icon && widget.icon == Icons.chevron_right,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Icon && widget.icon == Icons.chevron_left,
      ),
      findsNothing,
    );
  });
}
