import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(
    BuildContext context, String title, String message) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(title),
        ),
        content: Text(message),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

Future<T?> showRoundedBottomSheet<T>({
  bool useRootNavigator = true,
  bool isScrollControlled = true,
  bool useSafeArea = false,
  required BuildContext context,
  required Widget child,
  bool isDismissible = true,
  bool enableDrag = true,
  AnimationController? transitionAnimationController,
  double radius = 8,
  Color backgroundColor = AppColors.white,
}) async {
  // case not fold
  return showModalBottomSheet<T>(
    isScrollControlled: isScrollControlled,
    useSafeArea: useSafeArea,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    context: context,
    backgroundColor: backgroundColor,
    builder: (context) => child,
  ).whenComplete(() async {
    //callback when the modal being closed
    // await SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitUp]);
  });
}