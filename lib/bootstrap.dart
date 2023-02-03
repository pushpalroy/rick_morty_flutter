import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:logging/logging.dart';
import 'package:rick_morty_flutter/bloc/app_bloc_observer.dart';
import 'package:rick_morty_flutter/firebase_options.dart';
import 'package:rick_morty_flutter/infrastructure/notifications/firebase_messaging.dart';
import 'package:rick_morty_flutter/injection.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder, String env) async {
  flutterLogError();
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureAppInjection(env);

  await runZonedGuarded(
    () async {
      Bloc.observer = AppBlocObserver();
      runApp(await builder());
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );

  GetIt.instance.get<RmFirebaseMessaging>().setupMessaging();
}

void flutterLogError() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Logger.root.level = Level.INFO; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
