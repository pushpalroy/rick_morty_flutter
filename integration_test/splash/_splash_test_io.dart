import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:rick_morty_flutter/main_testing.dart' as app;
import 'package:rick_morty_flutter/presentation/core/widgets/platform_button.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('verify text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    app.main();

    // Trace the timeline of the following operation. The timeline result will
    // be written to `build/integration_response_data.json` with the key
    // `timeline`.
    await (binding as IntegrationTestWidgetsFlutterBinding)
        .traceAction(() async {
      // Trigger a frame.
      await tester.pumpAndSettle();
      final button = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text && widget.data == "Press Me!",
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
  });
}
