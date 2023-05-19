import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_flutter/presentation/core/widgets/abstract_plaform_widget.dart';

class RmButton
    extends AbstractPlatformWidget<CupertinoButton, MaterialButton> {
  const RmButton({super.key, required this.title, required this.onPressed});
  final String title;
  final Function() onPressed;

  @override
  CupertinoButton buildCupertino(BuildContext context) {
    return CupertinoButton(onPressed: onPressed, child: Text(title));
  }

  @override
  MaterialButton buildMaterial(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).colorScheme.secondary,
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
