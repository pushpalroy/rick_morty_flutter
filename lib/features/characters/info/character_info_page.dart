import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/ui_state.dart';
import '../../../ui/model/characters/ui_character_info.dart';
import 'character_info_cubit.dart';
import 'character_info_widgets.dart';

class CharacterInfoPage extends StatelessWidget {
  const CharacterInfoPage({Key? key, required this.characterId})
      : super(key: key);

  final String characterId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CharacterInfoCubit(characterId),
      child: BlocListener<CharacterInfoCubit, UiState<UiCharacterInfo>>(
        child: const CharacterInfoWidget(),
        listener: (context, state) {},
      ),
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
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0;
  double opacity2 = 0;
  double opacity3 = 0;

  @override
  void initState() {
    animationController = getAnimationController();
    animation = createAnimation();
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterInfoCubit, UiState<UiCharacterInfo>>(
      builder: (context, state) {
        return state is Success
            ? ColoredBox(
                color: Colors.white,
                child: getCharacterInfoWidget(
                  context,
                  animationController,
                  opacity1,
                  opacity2,
                  opacity3,
                  (state as Success).data.image as String,
                  (state as Success).data.name as String,
                  (state as Success).data.status as String,
                  (state as Success).data.species as String,
                  (state as Success).data.gender as String,
                  (state as Success).data.origin as String,
                  (state as Success).data.location as String,
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
