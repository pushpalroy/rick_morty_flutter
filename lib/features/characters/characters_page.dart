import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_flutter/features/characters/characters_cubit.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character.dart';
import 'characters_list_view.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CharactersCubit(),
      child: BlocListener<CharactersCubit, UiState<UiCharacterList>>(
        child: const CharactersListView(),
        listener: (context, state) {},
      ),
    );
  }
}
