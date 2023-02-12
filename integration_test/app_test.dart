import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rick_morty_flutter/main_development.dart' as app;

import 'robots/characters_screen_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized().framePolicy =
      LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  CharactersScreenRobot charactersScreenRobot;

  group(
    'Happy path e2e tests',
    () {
      testWidgets('scroll down and up, click on a character, navigate back',
          (tester) async {
        app.main();

        charactersScreenRobot = CharactersScreenRobot(tester);

        await charactersScreenRobot.findTheTabs();
        await charactersScreenRobot.scrollDownThePage();
        await charactersScreenRobot.scrollUpThePage();
        await charactersScreenRobot.clickOnItemWithID(id: '1');
        await charactersScreenRobot.navigateBack();
      });
    },
  );
}
