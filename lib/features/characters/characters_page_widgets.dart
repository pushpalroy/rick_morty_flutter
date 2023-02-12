import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:like_button/like_button.dart';
import 'package:rick_morty_flutter/features/characters/characters_cubit.dart';
import 'package:rick_morty_flutter/routing/routes.dart';
import 'package:rick_morty_flutter/ui/model/characters/ui_character.dart';

Widget buildCharactersListWidget({
  required BuildContext context,
  required TextEditingController searchTextController,
  required AnimationController? animationController,
  required List<UiCharacter> charactersList,
  required Function onScrolledToEndCallback,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      getSearchBarUI(context, searchTextController),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: FutureBuilder<bool>(
            future: delay(),
            builder: (
              BuildContext context,
              AsyncSnapshot<bool> snapshot,
            ) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent) {
                      onScrolledToEndCallback();
                    }
                    return false;
                  },
                  child: GridView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    children: List<Widget>.generate(
                      charactersList.length,
                      (int index) {
                        final count = charactersList.length;
                        animationController?.forward();
                        return CharacterItemWidget(
                          callback: (characterId) {
                            // Navigate to character information
                            context.push(
                              characterRoute,
                              extra: characterId,
                            );
                          },
                          character: charactersList[index],
                          animation: getListAnimation(
                            count,
                            index,
                            animationController!,
                          ),
                          animationController: animationController,
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ),
      )
    ],
  );
}

Future<bool> delay() async {
  await Future<dynamic>.delayed(const Duration(milliseconds: 100));
  return true;
}

Animation<double> getListAnimation(
  int count,
  int index,
  AnimationController animationController,
) {
  return Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Interval(
        (1 / count) * index,
        1,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    ),
  );
}

class CharacterItemWidget extends StatelessWidget {
  const CharacterItemWidget({
    Key? key,
    this.character,
    this.animationController,
    this.animation,
    required this.callback,
  }) : super(key: key);

  final void Function(String) callback;
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
              0,
              50 * (1.0 - animation!.value),
              0,
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback(character!.id);
              },
              child: SizedBox(
                height: 290,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              color: Color(0xffedeff0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
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
                                          top: 16,
                                          left: 16,
                                          right: 16,
                                        ),
                                        child: Text(
                                          character!.name,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            letterSpacing: 0.27,
                                            color: Color(0xff807e7e),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                          left: 8,
                                          right: 8,
                                          bottom: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              character!.species,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 12,
                                                letterSpacing: 0.27,
                                                color: Color(0xff807e7e),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            const Text(
                                              '.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12,
                                                letterSpacing: 0.27,
                                                color: Color(0xff807e7e),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              character!.status,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 12,
                                                letterSpacing: 0.27,
                                                color: Color(0xff6e6d6d),
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
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.9),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(character!.image),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 24,
                          //give the values according to your requirement
                          child: LikeButton(
                            size: 24,
                            circleColor: const CircleColor(
                              start: Color(0xffff4545),
                              end: Color(0xffffbcbc),
                            ),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: Color(0xffff5050),
                              dotSecondaryColor: Color(0xffff6100),
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                Icons.favorite,
                                color: isLiked
                                    ? const Color(0xffff3737)
                                    : const Color(0xa3ffffff),
                                size: 24,
                              );
                            },
                          ),
                        ),
                      ],
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

Widget getSearchBarUI(
  BuildContext context,
  TextEditingController searchTextController,
) {
  final cubit = context.read<CharactersCubit>();
  return Padding(
    padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: 64,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFB),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(13),
                  bottomLeft: Radius.circular(13),
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.zero,
                      child: TextFormField(
                        controller: searchTextController,
                        style: const TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Search for characters',
                          border: InputBorder.none,
                          helperStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFFB9BABC),
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 0.2,
                            color: Color(0xFFB9BABC),
                          ),
                        ),
                        onEditingComplete: () {},
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      cubit
                        ..nameFilter = searchTextController.text
                        ..loadCharacters();
                    },
                    child: const SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: Color(0xFFB9BABC)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const Expanded(
          child: SizedBox(),
        )
      ],
    ),
  );
}
