import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_flutter/features/locations/locations_view_model.dart';
import 'package:rick_morty_flutter/models/ui_state.dart';
import 'package:rick_morty_flutter/ui/model/locations/ui_location.dart';
import '../../presentation/core/widgets/platform_progress_bar.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocationsViewModel(),
        )
      ],
      child: const LocationsListWidget(),
    );
  }
}

class LocationsListWidget extends StatefulWidget {
  const LocationsListWidget({Key? key, this.callBack}) : super(key: key);

  final void Function()? callBack;

  @override
  State<StatefulWidget> createState() => _LocationsListWidgetState();
}

class _LocationsListWidgetState extends State<LocationsListWidget>
    with SingleTickerProviderStateMixin {
  late LocationsViewModel viewModel;
  AnimationController? animationController;
  final searchTextController = TextEditingController();

  @override
  void initState() {
    viewModel = Provider.of<LocationsViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.loadLocations();
    });
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
    return Consumer<LocationsViewModel>(
      builder: (_, viewModel, child) {
        return viewModel.locationsUiState is Loading
            ? const Align(
                child: RmProgressBar(),
              )
            : viewModel.locationsUiState is Success
                ? FutureBuilder<bool>(
                    future: delay(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      } else {
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: (viewModel.locationsUiState as Success)
                              .data.data
                              .length as int?,
                          itemBuilder: (BuildContext context, int index) {
                            return LocationItemWidget(
                              location: (viewModel.locationsUiState as Success)
                                  .data.data[index] as UiLocation,
                            );
                          },
                        );
                      }
                    },
                  )
                : Container();
      },
    );
  }

  Animation<double> getListAnimation(int count, int index) {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0.5, 1, curve: Curves.fastLinearToSlowEaseIn),
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
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(0, 4),
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
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
                                  '.',
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
  HexColor(String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
