import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_flutter/features/characters/characters_page.dart';
import 'package:rick_morty_flutter/features/locations/locations_page.dart';
import 'package:rick_morty_flutter/presentation/core/widgets/platform_scaffold.dart';

import 'dashboard_view_model.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DashboardViewModel(),
        )
      ],
      child: const TabBarPage(),
    );
  }
}

class TabBarPage extends StatelessWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: RmScaffold(
        androidAppBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(child: Text('Characters')),
              Tab(child: Text('Locations')),
              Tab(child: Text('Episodes')),
            ],
          ),
          title: text(),
        ),
        iosNavBar: CupertinoNavigationBar(
          middle: text(),
        ),
        body: Consumer<DashboardViewModel>(
          builder: (_, viewModel, child) {
            return const TabBarView(
              children: [
                CharactersPage(),
                LocationsPage(),
                Icon(Icons.directions_bike),
              ],
            );
          },
        ),
      ),
    );
  }

  Text text() => const Text('Rick & Morty');
}
