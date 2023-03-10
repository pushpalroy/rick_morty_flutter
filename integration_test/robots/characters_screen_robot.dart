import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class CharactersScreenRobot {
  const CharactersScreenRobot(this.tester);

  final WidgetTester tester;

  Future<void> findTheTabs() async {
    await tester.pumpAndSettle();
    expect(find.text('Characters'), findsOneWidget);
    expect(find.text('Locations'), findsOneWidget);
    expect(find.text('Episodes'), findsOneWidget);
    sleep(const Duration(seconds: 1));
  }

  Future<void> scrollDownThePage() async {
    final listFinder = find.byKey(const Key('characterListView'));
    await tester.fling(listFinder, const Offset(0, -500), 600);
    await tester.pumpAndSettle();
  }

  Future<void> findItemWithName({String name = ''}) async {
    expect(find.text(name), findsOneWidget);
  }

  Future<void> scrollUpThePage() async {
    final listFinder = find.byKey(const Key('characterListView'));
    await tester.fling(listFinder, const Offset(0, 500), 5000);
    await tester.pumpAndSettle();
  }

  Future<void> clickOnItemWithID({required String id}) async {
    final itemFinder = find.byKey(Key('characterItem:$id'));
    await tester.ensureVisible(itemFinder);
    await tester.tap(itemFinder);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
  }

  Future<void> navigateBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
  }

  Future<void> typeInSearchBox({required String searchInput}) async {
    // Find textField
    final searchText = find.byKey(const ValueKey('searchTextField'));
    // Ensure there is a search field on the page
    expect(searchText, findsOneWidget);
    // Enter text
    await tester.enterText(searchText, searchInput);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
    // Tap search button
    final searchBtn = find.byKey(const ValueKey('searchBtn'));
    await tester.tap(searchBtn);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
  }
}

class FinderType extends Finder {
  FinderType(this.finder, this.key);

  final Finder finder;
  final Key key;

  @override
  Iterable<Element> apply(Iterable<Element> candidates) {
    return finder.apply(candidates);
  }

  @override
  String get description => finder.description;

  Finder get title => find.descendant(of: this, matching: find.byKey(key));
}
