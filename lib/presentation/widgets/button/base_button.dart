import 'package:flutter/cupertino.dart';

abstract class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.buttonName,
    required this.onClick,
    this.isActive = true,
    this.contentPadding,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.contentAlign = MainAxisAlignment.center,
    this.maxLines = 2,
  });

  final String buttonName;
  final VoidCallback onClick;
  final bool isActive;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final MainAxisAlignment contentAlign;
  final int maxLines;
}
