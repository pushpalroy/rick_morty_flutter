import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_flutter/features/locations/locations_cubit.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/locations/ui_location.dart';
import '../../presentation/core/widgets/platform_progress_bar.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationsCubit(),
      child: BlocListener<LocationsCubit, UiState<List<UiLocation>>>(
        child: const LocationsListWidget(),
        listener: (context, state) {},
      ),
    );
  }
}

class LocationsListWidget extends StatefulWidget {
  const LocationsListWidget({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;

  @override
  State<StatefulWidget> createState() => _LocationsListWidgetState();
}

class _LocationsListWidgetState extends State<LocationsListWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  final searchTextController = TextEditingController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    super.initState();
  }

  Future<bool> delay() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 100));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsCubit, UiState<List<UiLocation>>>(
        builder: (context, state) {
      return state is Loading
          ? const Align(
              alignment: Alignment.center,
              child: RmProgressBar(),
            )
          : state is Success
              ? FutureBuilder<bool>(
                  future: delay(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    } else {
                      return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: (state as Success).data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return LocationItemWidget(
                                location: (state as Success).data[index]);
                          });
                    }
                  },
                )
              : Container();
    });
  }

  Animation<double> getListAnimation(int count, int index) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0.5, 1.0, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );
  }
}

class LocationItemWidget extends StatelessWidget {
  const LocationItemWidget({Key? key, this.location}) : super(key: key);

  final UiLocation? location;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      child: SizedBox(
        height: 90,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(0.0, 4.0),
                        blurRadius: 6.0),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16),
                            child: Text(
                              location!.name,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                letterSpacing: 0.27,
                                color: Color(0xff4783ad),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 16, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  location!.type,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 14,
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
                                  location!.dimension,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 14,
                                    letterSpacing: 0.27,
                                    color: HexColor('#6e6d6d'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
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