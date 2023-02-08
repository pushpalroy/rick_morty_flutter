import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_flutter/features/characters/characters_cubit.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/routing/routes.dart';
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
  const CharactersListWidget({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;

  @override
  State<StatefulWidget> createState() => _CharactersListWidgetState();
}

class _CharactersListWidgetState extends State<CharactersListWidget>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  var page = 1;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersCubit, UiState<List<UiCharacter>>>(
        builder: (context, state) {
      return state is Loading
          ? const Align(
              alignment: Alignment.center,
              child: RmProgressBar(),
            )
          : state is Success
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: FutureBuilder<bool>(
                    future: getData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      } else {
                        return NotificationListener<ScrollNotification>(
                            onNotification: (scrollNotification) {
                              if (scrollNotification.metrics.pixels ==
                                  scrollNotification.metrics.maxScrollExtent) {
                                setState(() {
                                  page++;
                                  context
                                      .read<CharactersCubit>()
                                      .loadCharacters(page: page);
                                });
                              }
                              return false;
                            },
                            child: GridView(
                              padding: const EdgeInsets.all(8),
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 24.0,
                                crossAxisSpacing: 16.0,
                                childAspectRatio: 0.8,
                              ),
                              children: List<Widget>.generate(
                                (state as Success).data.length,
                                (int index) {
                                  final int count =
                                      (state as Success).data.length;
                                  final Animation<double> animation =
                                      Tween<double>(begin: 0.0, end: 1.0)
                                          .animate(
                                    CurvedAnimation(
                                      parent: animationController!,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn),
                                    ),
                                  );
                                  animationController?.forward();
                                  return CategoryView(
                                    callback: () {
                                      moveTo(context);
                                    },
                                    character: (state as Success).data[index],
                                    animation: animation,
                                    animationController: animationController,
                                  );
                                },
                              ),
                            ));
                      }
                    },
                  ),
                )
              : Container();
    });
  }

  void moveTo(BuildContext context) {
    context.push(characterRoute);
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key? key,
      this.character,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final UiCharacter? character;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: callback,
              child: SizedBox(
                height: 290,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: HexColor('#edeff0'),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              // border: new Border.all(
                              //     color: DesignCourseAppTheme.notWhite),
                            ),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16, left: 16, right: 16),
                                        child: Text(
                                          character!.name,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            letterSpacing: 0.27,
                                            color: HexColor('#807e7e'),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8,
                                            left: 8,
                                            right: 8,
                                            bottom: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              character!.species,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 12,
                                                letterSpacing: 0.27,
                                                color: HexColor('#807e7e'),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              ".",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12,
                                                letterSpacing: 0.27,
                                                color: HexColor('#807e7e'),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              character!.status,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 12,
                                                letterSpacing: 0.27,
                                                color: HexColor('#6e6d6d'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 48,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, right: 16, left: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.9),
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(character!.image)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
