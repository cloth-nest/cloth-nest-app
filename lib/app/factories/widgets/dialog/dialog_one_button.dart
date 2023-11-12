import 'dart:io';
import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> dialogOneButton(
  BuildContext context, {
  String? title,
  String? content,
  required String buttonOne,
  required VoidCallback buttonOneTap,
}) {
  if (Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (_) {
        return iosDialogOneButton(
          context,
          title: title,
          content: content,
          buttonOne: buttonOne,
          buttonOneTap: buttonOneTap,
        );
      },
    );
  }
  return showDialog(
    context: context,
    builder: (_) {
      return androidDialogOneButton(context,
          title: title,
          content: content,
          buttonOne: buttonOne,
          buttonOneTap: buttonOneTap);
    },
  );
}

Widget androidDialogOneButton(
  BuildContext context, {
  String? title,
  String? content,
  required String buttonOne,
  required VoidCallback buttonOneTap,
}) {
  return AlertDialog(
    title: title == null
        ? null
        : Text(
            title,
            textAlign: TextAlign.center,
          ),
    content: content == null
        ? null
        : Text(
            content,
            textAlign: TextAlign.center,
          ),
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(onPressed: buttonOneTap, child: Text(buttonOne)),
          TextButton(
            onPressed: () async {
              await Beamer.of(context, root: true).popRoute();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    ],
  );
}

Widget iosDialogOneButton(
  BuildContext context, {
  String? title,
  String? content,
  required String buttonOne,
  required VoidCallback buttonOneTap,
}) {
  return CupertinoAlertDialog(
    title: title == null ? null : Text(title),
    content: content == null ? null : Text(content),
    actions: [
      TextButton(
        onPressed: () async {
          await Beamer.of(context, root: true).popRoute();
        },
        child: const Text('Cancel'),
      ),
      TextButton(onPressed: buttonOneTap, child: Text(buttonOne)),
    ],
  );
}
