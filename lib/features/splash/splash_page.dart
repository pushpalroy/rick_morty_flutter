import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_flutter/features/splash/splash_cubit.dart';
import 'package:rick_morty_flutter/presentation/core/widgets/platform_button.dart';
import 'package:rick_morty_flutter/presentation/core/widgets/platform_scaffold.dart';
import 'package:rick_morty_flutter/routing/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RmScaffold(
        androidAppBar: AppBar(
          title: praxisPlayground(),
        ),
        iosNavBar: CupertinoNavigationBar(
          middle: praxisPlayground(),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              flutterLogo(),
              verticalSpace(),
              pressMeButton(),
              verticalSpace(),
              loginButton(context)
            ],
          ),
        ));
  }

  FlutterLogo flutterLogo() {
    return const FlutterLogo(
      size: 160,
    );
  }

  SizedBox verticalSpace() {
    return const SizedBox(
      height: 24,
    );
  }

  pressMeButton() {
    return BlocBuilder<SplashCubit, bool>(builder: (context, selected) {
      return RmButton(
        title: !selected ? "Press Me!" : "You Pressed me! woo hoo!",
        onPressed: () {
          context.read<SplashCubit>().toggle();
        },
      );
    });
  }

  RmButton loginButton(BuildContext context) {
    return RmButton(
      title: "Login ?",
      onPressed: () {
        context.go(loginRoute);
      },
    );
  }

  Text praxisPlayground() => const Text("Welcome to Rick and Morty Flutter");
}
