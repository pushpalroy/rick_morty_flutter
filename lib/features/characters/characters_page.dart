import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_flutter/features/characters/characters_cubit.dart';
import 'package:rick_morty_flutter/features/characters/characters_page_widgets.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character.dart';
import '../../presentation/core/widgets/platform_progress_bar.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CharactersCubit(),
      child: BlocListener<CharactersCubit, UiState<List<UiCharacter>>>(
        child: const CharactersListWidget(),
        listener: (context, state) {},
      ),
    );
  }
}

class CharactersListWidget extends StatefulWidget {
  const CharactersListWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CharactersListWidgetState();
}

class _CharactersListWidgetState extends State<CharactersListWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  final searchTextController = TextEditingController();

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersCubit, UiState<List<UiCharacter>>>(
      builder: (context, state) {
        final cubit = context.read<CharactersCubit>();
        return state is Loading
            ? const Align(
                child: RmProgressBar(),
              )
            : state is Success
                ? buildCharactersListWidget(
                    context: context,
                    searchTextController: searchTextController,
                    animationController: animationController,
                    charactersList:
                        (state as Success).data as List<UiCharacter>,
                    onScrolledToEndCallback: () {
                      setState(
                        () {
                          if (!cubit.isPageLoadInProgress) {
                            cubit.page++;
                            cubit
                              ..loadCharacters()
                              ..isPageLoadInProgress = true;
                          }
                        },
                      );
                    },
                  )
                : Container();
      },
    );
  }
}
