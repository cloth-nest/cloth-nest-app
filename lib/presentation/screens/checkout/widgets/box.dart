import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? height;

  const Box({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: height,
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}
