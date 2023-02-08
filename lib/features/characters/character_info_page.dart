import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/ui_state.dart';
import '../../presentation/core/widgets/platform_progress_bar.dart';
import '../../ui/model/characters/ui_character_info.dart';
import 'character_info_cubit.dart';

class CharacterInfoPage extends StatelessWidget {
  const CharacterInfoPage({Key? key, required this.characterId}) : super(key: key);

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
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
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

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return BlocBuilder<CharacterInfoCubit, UiState<UiCharacterInfo>>(
        builder: (context, state) {
      return state is Loading
          ? const Align(
              alignment: Alignment.center,
              child: RmProgressBar(),
            )
          : state is Success
              ? Container(
                  color: Colors.white,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                    (state as Success).data.image,
                                    fit: BoxFit.fill)),
                          ],
                        ),
                        Positioned(
                          top: (MediaQuery.of(context).size.width / 1.1),
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(32.0),
                                  topRight: Radius.circular(32.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: SingleChildScrollView(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minHeight: infoHeight,
                                      maxHeight: tempHeight > infoHeight
                                          ? tempHeight
                                          : infoHeight),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 32.0, left: 18, right: 16),
                                        child: Text(
                                          (state as Success).data.name,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                            letterSpacing: 0.27,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            bottom: 8,
                                            top: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              (state as Success).data.species,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 22,
                                                letterSpacing: 0.27,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  (state as Success)
                                                      .data
                                                      .status,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 22,
                                                    letterSpacing: 0.27,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.blue,
                                                  size: 24,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        opacity: opacity1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            children: <Widget>[
                                              getTimeBoxUI('24', 'Classe'),
                                              getTimeBoxUI('2hours', 'Time'),
                                              getTimeBoxUI('24', 'Seat'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: AnimatedOpacity(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          opacity: opacity2,
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 8,
                                                bottom: 8),
                                            child: Text(
                                              'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 14,
                                                letterSpacing: 0.27,
                                                color: Colors.grey,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context)
                                            .padding
                                            .bottom,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: (MediaQuery.of(context).size.width / 1.2) -
                              24.0 -
                              35,
                          right: 35,
                          child: ScaleTransition(
                            alignment: Alignment.center,
                            scale: CurvedAnimation(
                                parent: animationController!,
                                curve: Curves.fastOutSlowIn),
                            child: Card(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              elevation: 10.0,
                              child: const SizedBox(
                                width: 60,
                                height: 60,
                                child: Center(
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top),
                          child: SizedBox(
                            width: AppBar().preferredSize.height,
                            height: AppBar().preferredSize.height,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                    AppBar().preferredSize.height),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container();
    });
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.blue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
