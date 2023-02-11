import 'package:go_router/go_router.dart';
import 'package:rick_morty_flutter/features/characters/info/character_info_page.dart';
import 'package:rick_morty_flutter/features/dashboard/dashboard_page.dart';

const rootRoute = '/';
const characterRoute = '/characterInfo';

final routes = GoRouter(
  routes: [dashboardRoute(), characterInfoRoute()],
);

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
      final characterId = state.extra as String?;
      return CharacterInfoPage(characterId: characterId ?? '0');
    },
  );
}
