// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:plusandminus/main.dart';

void main() {
  testWidgets('Counter increment', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsNWidgets(2));
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Minus button decrements below zero', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byTooltip('Decrement'));
    await tester.pump();
    expect(find.text('-1'), findsOneWidget);

    await tester.tap(find.byTooltip('Decrement'));
    await tester.pump();
    expect(find.text('-2'), findsOneWidget);
    expect(find.text('-1'), findsNothing);
  });

  for (final startingValue in [2, -2, 0]) {
    testWidgets('Zero button resets $startingValue to zero', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      final button = find.byTooltip(
        startingValue > 0 ? 'Increment' : 'Decrement',
      );
      for (var tap = 0; tap < startingValue.abs(); tap++) {
        await tester.tap(button);
        await tester.pump();
      }

      // Scope the finder to the body so the reset button's label is excluded.
      final body = find.byType(Column);
      expect(
        find.descendant(of: body, matching: find.text('$startingValue')),
        findsOneWidget,
      );

      await tester.tap(find.byTooltip('Reset to zero'));
      await tester.pump();

      expect(
        find.descendant(of: body, matching: find.text('0')),
        findsOneWidget,
      );
    });
  }
}
