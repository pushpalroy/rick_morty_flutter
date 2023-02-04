import 'package:go_router/go_router.dart';
import 'package:rick_morty_flutter/features/dashboard/dashboard_page.dart';
import 'package:rick_morty_flutter/features/home/home_page.dart';
import 'package:rick_morty_flutter/features/joke_list/joke_list_page.dart';
import 'package:rick_morty_flutter/features/login/login_page.dart';
import 'package:rick_morty_flutter/features/splash/splash_page.dart';

const loginRoute = '/login';
const jokeListRoute = "/jokesList";
const dashboardRoutePath = "/dashboard";
const homeRoute = '/home';
const rootRoute = '/';

final routes = GoRouter(
  routes: [
    // splashRoute(),
    loginPageRoute(),
    homePageRoute(),
    jokeListRoutePage(),
    dashboardRoute()
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

// GoRoute splashRoute() {
//   return GoRoute(
//     path: rootRoute,
//     builder: (context, state) => const SplashPage(),
//   );
// }

GoRoute dashboardRoute() {
  return GoRoute(
    path: rootRoute,
    builder: (context, state) => const DashboardPage(),
  );
}