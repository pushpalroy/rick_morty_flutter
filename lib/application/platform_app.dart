import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rick_morty_flutter/l10n/l10n.dart';
import 'package:rick_morty_flutter/presentation/core/widgets/abstract_plaform_widget.dart';
import 'package:rick_morty_flutter/routing/routes.dart';

class RickMortyApp extends AbstractPlatformWidget<CupertinoApp, MaterialApp> {
  /// Platform dependent app widget (CupertinoApp for iOS, MaterialApp for android)
  final String title;

  const RickMortyApp({Key? key, this.title = 'Praxis'}) : super(key: key);

  @override
  CupertinoApp buildCupertino(BuildContext context) {
    return CupertinoApp.router(
      routeInformationProvider: routes.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: title,
      theme: const CupertinoThemeData(),
      routeInformationParser: routes.routeInformationParser,
      routerDelegate: routes.routerDelegate,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  @override
  MaterialApp buildMaterial(BuildContext context) {
    var lightTheme =
        FlexColorScheme.light(scheme: FlexScheme.blueWhale).toTheme;
    var darkTheme = FlexColorScheme.dark(scheme: FlexScheme.blueWhale).toTheme;
    return MaterialApp.router(
      routeInformationProvider: routes.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      title: title,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routeInformationParser: routes.routeInformationParser,
      routerDelegate: routes.routerDelegate,
    );
  }
}
