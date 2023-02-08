import 'package:go_router/go_router.dart';
import 'package:rick_morty_flutter/features/characters/character_info_page.dart';
import 'package:rick_morty_flutter/features/dashboard/dashboard_page.dart';
import 'package:rick_morty_flutter/features/home/home_page.dart';
import 'package:rick_morty_flutter/features/joke_list/joke_list_page.dart';
import 'package:rick_morty_flutter/features/login/login_page.dart';

const loginRoute = '/login';
const jokeListRoute = "/jokesList";
const homeRoute = '/home';
const rootRoute = '/';
const characterRoute = "/characterInfo";

final routes = GoRouter(
  routes: [
    loginPageRoute(),
    homePageRoute(),
    jokeListRoutePage(),
    dashboardRoute(),
    characterInfoRoute()
  ],
);

GoRoute jokeListRoutePage() {
  return GoRoute(
    path: jokeListRoute,
    builder: (context, state) => const JokesPage(),
  );
}

GoRoute homePageRoute() {
  return GoRoute(
    path: homeRoute,
    builder: (context, state) => const HomePage(),
  );
}

GoRoute loginPageRoute() {
  return GoRoute(
    path: loginRoute,
    builder: (context, state) => const LoginPage(),
  );
}

GoRoute dashboardRoute() {
  return GoRoute(
    path: rootRoute,
    builder: (context, state) => const DashboardPage(),
  );
}

GoRoute characterInfoRoute() {
  return GoRoute(
    path: characterRoute,
    builder: (context, state) {
      String characterId = state.extra as String;
      return CharacterInfoPage(
        characterId: characterId
      );
    },
  );
}