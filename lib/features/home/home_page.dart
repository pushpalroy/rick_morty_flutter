import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_flutter/presentation/core/widgets/platform_button.dart';
import 'package:rick_morty_flutter/presentation/core/widgets/platform_dialog.dart';
import 'package:rick_morty_flutter/presentation/core/widgets/platform_scaffold.dart';
import 'package:rick_morty_flutter/presentation/core/extensions/widget_extensions.dart';
import 'package:rick_morty_flutter/routing/routes.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RmScaffold(
        androidAppBar: AppBar(
          title: appBarTitle(),
        ),
        iosNavBar: CupertinoNavigationBar(
          middle: appBarTitle(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            heading().paddingAll(4),
            showRandomJokes(context).paddingAll(4),
            aboutWidget(context).paddingAll(4)
          ],
        ));
  }

  Widget aboutWidget(context) {
    return RmButton(
        title: "About",
        onPressed: () {
          showAlertDialog(
              context: context,
              title: "About Praxis",
              content:
                  "PraxisFlutter is a sample flutter app which can be used as a base project for other projects written in flutter. "
                  "The app uses clean architecture to provide a robust base to the app.\n\n"
                  "The http library is used to fetch jokes along with the async/await which handles connections asynchronously and makes the app more reliable.",
              defaultActionText: "OK");
        });
  }

  Widget heading() {
    return const Text(
      "Chuck Norris Random Joke Generator",
    );
  }

  Text appBarTitle() => const Text("Praxis");

  Widget showRandomJokes(BuildContext context) {
    return RmButton(
        title: "Show random Jokes",
        onPressed: () {
          context.push(jokeListRoute);
        });
  }
}
