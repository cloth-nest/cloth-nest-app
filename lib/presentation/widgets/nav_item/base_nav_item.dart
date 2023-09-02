import 'package:flutter/material.dart';

abstract class BaseNavItem extends StatelessWidget {
  final double iconSize = 20.0;
  final double itemHeight = 50.0;
  final Color color;
  final String iconPath;
  final String defaultIconColor;

  const BaseNavItem({
    Key? key,
    required this.iconPath,
    required this.defaultIconColor,
    this.color = Colors.black,
  }) : super(key: key);
}
