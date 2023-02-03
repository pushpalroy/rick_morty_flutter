import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:rick_morty_flutter/main_testing.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('verify text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    app.main();

    // Trigger a frame.
    await tester.pumpAndSettle();

    final button = find.byWidgetPredicate(
          (Widget widget) =>
          widget is Text && widget.data  == "Press Me!",
    );
    expect(
      button,
      findsOneWidget,
    );

    var pressButton = find.text("Press Me!");
    await tester.tap(pressButton);

    await tester.pump(const Duration(milliseconds: 500));

    expect(
      find.byWidgetPredicate(
            (Widget widget) =>
        widget is Text && widget.data == "You Pressed me! woo hoo!",
      ),
      findsOneWidget,
    );
  });
}
