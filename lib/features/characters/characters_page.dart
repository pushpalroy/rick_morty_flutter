import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_flutter/features/characters/characters_cubit.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/presentation/core/extensions/widget_extensions.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character.dart';
import '../../presentation/core/widgets/platform_progress_bar.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CharactersCubit(),
      child: BlocListener<CharactersCubit, UiState<UiCharacterList>>(
        child: const CharacterListPage(),
        listener: (context, state) {},
      ),
    );
  }
}

class CharacterListPage extends StatelessWidget {
  const CharacterListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersCubit, UiState<UiCharacterList>>(
        builder: (context, state) {
      return Stack(
        alignment: Alignment.center,
        children: [
          state is Loading
              ? const Align(
                  alignment: Alignment.center,
                  child: RmProgressBar(),
                )
              : state is Success
                  ? buildCharactersList(state as Success)
                  : Container()
        ],
      );
    });
  }

  ListView buildCharactersList(Success state) {
    return ListView.builder(
        itemCount: state.data.characters.length,
        itemBuilder: (context, index) {
          return Text(state.data.characters[index].name).paddingAll(8);
        });
  }
}
