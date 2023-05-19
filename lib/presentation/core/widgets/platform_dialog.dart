import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<dynamic> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? cancelActionText,
  required String defaultActionText,
}) async {
  if (kIsWeb) {
    return materialDialog(
      context,
      title,
      content,
      cancelActionText,
      defaultActionText,
    );
  }
  return Platform.isIOS || Platform.isMacOS
      ? cupertinoDialog(
          context,
          title,
          content,
          cancelActionText,
          defaultActionText,
        )
      : materialDialog(
          context,
          title,
          content,
          cancelActionText,
          defaultActionText,
        );
}

Future<dynamic> cupertinoDialog(
  BuildContext context,
  String title,
  String content,
  String? cancelActionText,
  String defaultActionText,
) {
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        CupertinoDialogAction(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}

Future<dynamic> materialDialog(
  BuildContext context,
  String title,
  String content,
  String? cancelActionText,
  String defaultActionText,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        if (cancelActionText != null)
          TextButton(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        TextButton(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}
