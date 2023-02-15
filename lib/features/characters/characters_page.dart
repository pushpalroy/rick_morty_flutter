import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_flutter/features/characters/characters_page_widgets.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character.dart';
import '../../presentation/core/widgets/platform_progress_bar.dart';
import 'characters_view_model.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CharactersViewModel(),
        )
      ],
      child: const CharactersListWidget(),
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
  late CharactersViewModel viewModel;
  AnimationController? animationController;
  final searchTextController = TextEditingController();

  @override
  void initState() {
    viewModel = Provider.of<CharactersViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.loadCharacters();
    });
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharactersViewModel>(
      builder: (_, viewModel, child) {
        return viewModel.charactersUiState is Loading
            ? const Align(
                child: RmProgressBar(),
              )
            : viewModel.charactersUiState is Success
                ? buildCharactersListWidget(
                    context: context,
                    searchTextController: searchTextController,
                    animationController: animationController,
                    charactersList: (viewModel.charactersUiState as Success)
                        .data.data as List<UiCharacter>,
                    onScrolledToEndCallback: () {
                      setState(
                        () {
                          if (!viewModel.isPageLoadInProgress) {
                            viewModel.page++;
                            viewModel
                              ..loadCharacters()
                              ..isPageLoadInProgress = true;
                          }
                        },
                      );
                    },
                    onSearchBtnTapCallback: () {
                      // viewModel
                      //   ..nameFilter = searchTextController.text
                      //   ..loadCharacters();
                    },
                  )
                : Container();
      },
    );
  }
}
