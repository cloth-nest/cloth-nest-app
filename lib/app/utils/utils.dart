import 'package:another_flushbar/flushbar.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

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

showSnackBar(BuildContext context, String content, Icon icon,
    {Color messageColor = AppColors.skyPerfectBlue}) {
  final size = MediaQuery.of(context).size;

  Flushbar(
    maxWidth: size.width * .8,
    borderRadius: BorderRadius.circular(10),
    backgroundColor: messageColor,
    flushbarPosition: FlushbarPosition.TOP,
    messageColor: Colors.white,
    messageSize: 16,
    message: content,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    icon: icon,
    boxShadows: [
      BoxShadow(
        offset: const Offset(0, 4),
        blurRadius: 6,
        color: const Color(0xFFBABABA).withOpacity(
          0.217,
        ),
      )
    ],
    duration: const Duration(seconds: 3),
  ).show(context);
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

void beamTo(BuildContext context, {required String path}) {
  final String currentLocation =
      context.currentBeamLocation.state.routeInformation.location ?? '/';
  final uri = Uri.parse(currentLocation);
  context.beamToNamed('${uri.path}/$path');
}
