import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_morty_flutter/presentation/core/widgets/abstract_plaform_widget.dart';

class RmTabScaffold
    extends AbstractPlatformWidget<CupertinoTabScaffold, Widget> {
  const RmTabScaffold({
    Key? key,
    required this.tabsIcons,
    required this.tabBuilder,
    this.currentIndex = 0,
  }) : super(key: key);

  /// List of icons, showed at the bottom navigation bar.
  final List<BottomNavigationBarItem> tabsIcons;

  /// Use builder, extend of list of widget, bacuse its better
  /// to have a correct context
  final Widget Function(BuildContext, int) tabBuilder;

  /// Defualt selected page
  final int currentIndex;

  @override
  CupertinoTabScaffold buildCupertino(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor:
            CupertinoTheme.of(context).scaffoldBackgroundColor.withOpacity(.65),
        currentIndex: currentIndex,
        items: tabsIcons,
      ),
      tabBuilder: tabBuilder,
    );
  }

  @override
  Widget buildMaterial(BuildContext context) {
    return _MaterialTabScaffold(
      tabsIcons: tabsIcons,
      tabBuilder: tabBuilder,
      currentIndex: currentIndex,
    );
  }
}

class _MaterialTabScaffold extends StatefulWidget {
  const _MaterialTabScaffold({
    Key? key,
    required this.tabsIcons,
    required this.tabBuilder,
    this.currentIndex = 0,
  }) : super(key: key);

  final List<BottomNavigationBarItem> tabsIcons;
  final Widget Function(BuildContext, int) tabBuilder;
  final int currentIndex;

  @override
  _MaterialTabScaffoldState createState() => _MaterialTabScaffoldState();
}

class _MaterialTabScaffoldState extends State<_MaterialTabScaffold> {
  late int _currentIndex = widget.currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CupertinoColors.darkBackgroundGray.withOpacity(0.65),
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        currentIndex: _currentIndex,
        items: widget.tabsIcons,
      ),
      body: widget.tabBuilder(context, _currentIndex),
    );
  }
}
