import 'package:flutter/material.dart';

abstract class BaseTextField extends StatefulWidget {
  final TextEditingController controller;
  final String placeHolder;
  final Widget? prefixIcon;
  final String? errorText;
  final bool autoFocus;
  final double prefixIconSize = 30;
  final double labelFontSize = 10;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputAction? textInputAction;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;
  final Function(bool?)? onFocusChanged;

  const BaseTextField({
    super.key,
    required this.controller,
    required this.placeHolder,
    this.autoFocus = false,
    this.prefixIcon,
    this.errorText,
    this.focusNode,
    this.nextFocus,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onFocusChanged,
  });
}
