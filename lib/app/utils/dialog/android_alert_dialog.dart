import 'package:ecommerce/app/utils/dialog/custom_dialog.dart';
import 'package:flutter/material.dart';

class AndroidAlertDialog extends CustomDialog {
  const AndroidAlertDialog({required super.title, required super.content});

  @override
  String getTitle() => title;

  @override
  Widget create(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
