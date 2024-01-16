import 'package:flutter/material.dart';

abstract class CustomDialog {
  final String title;
  final String content;

  const CustomDialog({required this.title, required this.content});

  String getTitle();
  Widget create(BuildContext context);

  Future<void> show(BuildContext context) => showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: create,
      );
}
