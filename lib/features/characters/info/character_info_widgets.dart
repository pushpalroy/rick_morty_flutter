import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:transparent_image/transparent_image.dart';

const double infoHeight = 364.0;

Widget getCharacterInfoWidget(
    BuildContext context,
    AnimationController? animationController,
    double opacity1,
    double opacity2,
    double opacity3,
    String imageUrl,
    String characterName,
    String characterStatus,
    String characterSpecies,
    String gender,
    String origin,
    String location) {
  final double tempHeight = MediaQuery.of(context).size.height -
      (MediaQuery.of(context).size.width / 1.2) +
      24.0;
  return Scaffold(
    backgroundColor: Colors.white,
    body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: imageUrl,
                imageScale: 1,
                fit: BoxFit.fill,
              ),
            ),
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
                      maxHeight:
                          tempHeight > infoHeight ? tempHeight : infoHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 48.0, left: 18, right: 16),
                        child: Text(
                          characterName,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 36,
                            letterSpacing: 0.27,
                            color: Color(0xFF676767),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18, right: 18, bottom: 8, top: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              characterSpecies,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 26,
                                letterSpacing: 0.27,
                                color: Color(0xFF0087E5),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.circle,
                                  color: characterStatus == 'Alive'
                                      ? const Color(0xFF6EB900)
                                      : const Color(0xFFDE0000),
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  characterStatus,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: Color(0xFF676767),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 800),
                        opacity: opacity1,
                        child: getCharacterBioWidget(gender, origin, location),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
          right: 35,
          child: ScaleTransition(
            alignment: Alignment.center,
            scale: CurvedAnimation(
                parent: animationController!, curve: Curves.fastOutSlowIn),
            child: Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              elevation: 10.0,
              child: SizedBox(
                width: 60,
                height: 60,
                child: Center(
                  child: LikeButton(
                      size: 32,
                      circleColor: const CircleColor(
                          start: Color(0xffff4545), end: Color(0xffffbcbc)),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Color(0xffff5050),
                        dotSecondaryColor: Color(0xffff6100),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          color: isLiked
                              ? const Color(0xffff3737)
                              : const Color(0xffffffff),
                          size: 32,
                        );
                      }),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: SizedBox(
            width: AppBar().preferredSize.height,
            height: AppBar().preferredSize.height,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
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
  );
}

Widget getCharacterInfoWidgetLoader(BuildContext context) {
  return Stack(
    children: <Widget>[
      Column(
        children: const <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: SizedBox(),
          ),
        ],
      ),
      Positioned(
        top: (MediaQuery.of(context).size.width / 1.1),
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0)),
            boxShadow: <BoxShadow>[],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(
                    minHeight: infoHeight, maxHeight: infoHeight),
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(),
                      child: SizedBox(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(),
                          Row(
                            children: const <Widget>[SizedBox()],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: const <Widget>[],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
        right: 35,
        child: Card(
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          child: const SizedBox(
            width: 60,
            height: 60,
            child: Center(),
          ),
        ),
      )
    ],
  );
}

Widget getCharacterBioWidget(String gender, String origin, String location) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Gender',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.27,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              gender,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
                letterSpacing: 0.27,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Origin',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.27,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              origin,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
                letterSpacing: 0.27,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Location',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.27,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              location,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
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
