import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rick_morty_flutter/main_development.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group(
    'Happy path e2e tests',
    () {
      testWidgets('scroll down and up, click on a character, navigate back',
          (tester) async {
        app.main();
        // Triggers the frames, until there is nothing to be scheduled
        await tester.pumpAndSettle();

        // Check for the texts on the tabs
        expect(find.text('Characters'), findsOneWidget);
        expect(find.text('Locations'), findsOneWidget);
        expect(find.text('Episodes'), findsOneWidget);

        // Scroll down and find a text
        final listFinder = find.byKey(const Key('characterListView'));
        await tester.fling(listFinder, const Offset(0, -500), 600);
        await tester.pumpAndSettle();
        expect(find.text('Albert Einstein'), findsOneWidget);

        // Scroll up
        await tester.fling(listFinder, const Offset(0, 500), 5000);
        await tester.pumpAndSettle();

        // Click on first item with ID 1
        final btnFinder = find.byKey(const Key('characterItem:1'));
        await tester.ensureVisible(btnFinder);
        await tester.tap(btnFinder);
        await tester.pumpAndSettle();

        // Navigate back
        find.byTooltip('Back');
        await tester.pumpAndSettle();
      });
    },
  );
}
