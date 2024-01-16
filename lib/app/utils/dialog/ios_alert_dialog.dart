import 'package:ecommerce/app/utils/dialog/custom_dialog.dart';
import 'package:flutter/cupertino.dart';

class IosAlertDialog extends CustomDialog {
  const IosAlertDialog({required super.title, required super.content});

  @override
  String getTitle() => title;

  @override
  Widget create(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        CupertinoButton(
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
