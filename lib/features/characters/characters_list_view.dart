// import 'package:domain/entities/characters/dm_character.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
//
// class CharactersListView extends StatefulWidget {
//   const CharactersListView({Key? key, this.callBack, required this.queryResult})
//       : super(key: key);
//
//   final Function()? callBack;
//   final QueryResult<Object?> queryResult;
//
//   @override
//   _CharactersListViewState createState() => _CharactersListViewState();
// }
//
// class _CharactersListViewState extends State<CharactersListView>
//     with TickerProviderStateMixin {
//   AnimationController? animationController;
//
//   @override
//   void initState() {
//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 2000), vsync: this);
//     super.initState();
//   }
//
//   Future<bool> getData() async {
//     await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8),
//       child: FutureBuilder<bool>(
//         future: getData(),
//         builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//           if (!snapshot.hasData) {
//             return const SizedBox();
//           } else {
//             return GridView(
//               padding: const EdgeInsets.all(8),
//               physics: const BouncingScrollPhysics(),
//               scrollDirection: Axis.vertical,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 32.0,
//                 crossAxisSpacing: 32.0,
//                 childAspectRatio: 0.8,
//               ),
//               children: List<Widget>.generate(
//                 queryResult.length,
//                 (int index) {
//                   final int count = queryResult.length;
//                   final Animation<double> animation =
//                       Tween<double>(begin: 0.0, end: 1.0).animate(
//                     CurvedAnimation(
//                       parent: animationController!,
//                       curve: Interval((1 / count) * index, 1.0,
//                           curve: Curves.fastOutSlowIn),
//                     ),
//                   );
//                   animationController?.forward();
//                   return CategoryView(
//                     callback: widget.callBack,
//                     character: queryResult[index],
//                     animation: animation,
//                     animationController: animationController,
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
// class CategoryView extends StatelessWidget {
//   const CategoryView(
//       {Key? key,
//       this.character,
//       this.animationController,
//       this.animation,
//       this.callback})
//       : super(key: key);
//
//   final VoidCallback? callback;
//   final Character? character;
//   final AnimationController? animationController;
//   final Animation<double>? animation;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animationController!,
//       builder: (BuildContext context, Widget? child) {
//         return FadeTransition(
//           opacity: animation!,
//           child: Transform(
//             transform: Matrix4.translationValues(
//                 0.0, 50 * (1.0 - animation!.value), 0.0),
//             child: InkWell(
//               splashColor: Colors.transparent,
//               onTap: callback,
//               child: SizedBox(
//                 height: 280,
//                 child: Stack(
//                   alignment: AlignmentDirectional.bottomCenter,
//                   children: <Widget>[
//                     Container(
//                       child: Column(
//                         children: <Widget>[
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: HexColor('#F8FAFB'),
//                                 borderRadius: const BorderRadius.all(
//                                     Radius.circular(16.0)),
//                                 // border: new Border.all(
//                                 //     color: DesignCourseAppTheme.notWhite),
//                               ),
//                               child: Column(
//                                 children: <Widget>[
//                                   Expanded(
//                                     child: Container(
//                                       child: Column(
//                                         children: <Widget>[
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 top: 16, left: 16, right: 16),
//                                             child: Text(
//                                               character!.name,
//                                               textAlign: TextAlign.left,
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 16,
//                                                 letterSpacing: 0.27,
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 top: 8,
//                                                 left: 16,
//                                                 right: 16,
//                                                 bottom: 8),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: <Widget>[
//                                                 Text(
//                                                   '${character!.name} lesson',
//                                                   textAlign: TextAlign.left,
//                                                   style: const TextStyle(
//                                                     fontWeight: FontWeight.w200,
//                                                     fontSize: 12,
//                                                     letterSpacing: 0.27,
//                                                     color: Colors.grey,
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 48,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 48,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(top: 24, right: 16, left: 16),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(16.0)),
//                           boxShadow: <BoxShadow>[
//                             BoxShadow(
//                                 color: Colors.grey
//                                     .withOpacity(0.2),
//                                 offset: const Offset(0.0, 0.0),
//                                 blurRadius: 6.0),
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(16.0)),
//                           child: AspectRatio(
//                               aspectRatio: 1.28,
//                               child: Image.asset(character!.image)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class HexColor extends Color {
//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
//
//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll('#', '');
//     if (hexColor.length == 6) {
//       hexColor = 'FF$hexColor';
//     }
//     return int.parse(hexColor, radix: 16);
//   }
// }
