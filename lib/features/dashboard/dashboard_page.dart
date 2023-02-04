import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_flutter/features/dashboard/dashboard_cubit.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/presentation/core/widgets/platform_scaffold.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(),
      child: BlocListener<DashboardCubit, UiState<UiCharacterList>>(
        child: const TabBarPage(),
        listener: (context, state) {},
      ),
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
            body: BlocBuilder<DashboardCubit, UiState<UiCharacterList>>(
                builder: (context, state) {
              return const TabBarView(
                children: [
                  Icon(Icons.directions_car),
                  Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                ],
              );
            })));
  }

  Text text() => const Text("Dashboard");
}
