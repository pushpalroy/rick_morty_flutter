import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AbstractPlatformWidget<C extends Widget, M extends Widget>
    extends StatelessWidget {
  const AbstractPlatformWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return buildMaterial(context);
    }
    return Platform.isIOS || Platform.isMacOS
        ? buildCupertino(context)
        : buildMaterial(context);
  }

  C buildCupertino(BuildContext context) => throw UnimplementedError();

  M buildMaterial(BuildContext context) => throw UnimplementedError();
}
