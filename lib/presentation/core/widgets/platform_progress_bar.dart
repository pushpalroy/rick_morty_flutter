import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_flutter/presentation/core/widgets/abstract_plaform_widget.dart';

class RmProgressBar
    extends AbstractPlatformWidget<
        CupertinoActivityIndicator,
        CircularProgressIndicator> {

  const RmProgressBar({super.key});

  @override
  CupertinoActivityIndicator buildCupertino(BuildContext context) {
    return const CupertinoActivityIndicator();
  }

  @override
  CircularProgressIndicator buildMaterial(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
