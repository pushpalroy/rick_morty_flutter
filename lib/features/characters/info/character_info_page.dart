import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/ui_state.dart';
import 'character_info_view_model.dart';
import 'character_info_widgets.dart';

class CharacterInfoPage extends StatelessWidget {
  const CharacterInfoPage({Key? key, required this.characterId})
      : super(key: key);

  final String characterId;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CharacterInfoViewModel(characterId: characterId),
        )
      ],
      child: const CharacterInfoWidget(),
    );
  }
}

class CharacterInfoWidget extends StatefulWidget {
  const CharacterInfoWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CharacterInfoWidget();
}

class _CharacterInfoWidget extends State<CharacterInfoWidget>
    with TickerProviderStateMixin {
  late CharacterInfoViewModel viewModel;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0;
  double opacity2 = 0;
  double opacity3 = 0;

  @override
  void initState() {
    viewModel = Provider.of<CharacterInfoViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.loadCharacterInfo(id: int.parse(viewModel.characterId));
    });
    animationController = getAnimationController();
    animation = createAnimation();
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterInfoViewModel>(
      builder: (_, viewModel, child) {
        return viewModel.characterInfoUiState is Success
            ? ColoredBox(
                color: Colors.white,
                child: getCharacterInfoWidget(
                  context,
                  animationController,
                  opacity1,
                  opacity2,
                  opacity3,
                  (viewModel.characterInfoUiState as Success).data.data.image
                      as String,
                  (viewModel.characterInfoUiState as Success).data.data.name
                      as String,
                  (viewModel.characterInfoUiState as Success).data.data.status
                      as String,
                  (viewModel.characterInfoUiState as Success).data.data.species
                      as String,
                  (viewModel.characterInfoUiState as Success).data.data.gender
                      as String,
                  (viewModel.characterInfoUiState as Success).data.data.origin
                      as String,
                  (viewModel.characterInfoUiState as Success).data.data.location
                      as String,
                ),
              )
            : Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: getCharacterInfoWidgetLoader(context),
              );
      },
    );
  }

  AnimationController getAnimationController() {
    return AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  Animation<double> createAnimation() {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  Future<void> setData() async {
    await animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }
}
