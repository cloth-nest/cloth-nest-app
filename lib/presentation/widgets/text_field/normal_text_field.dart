import 'package:ecommerce/presentation/widgets/text_field/base_text_field.dart';
import 'package:flutter/material.dart';

class NormalTextField extends BastTextField {
  const NormalTextField({
    super.key,
    required super.controller,
    required super.placeHolder,
    super.autoFocus,
    super.errorText,
    super.focusNode,
    super.nextFocus,
    super.onChanged,
    super.onFocusChanged,
    super.onSubmitted,
    super.prefixIcon,
    super.textInputAction = TextInputAction.done,
  });

  @override
  State<StatefulWidget> createState() => BTextFieldState();
}

class BTextFieldState extends State<NormalTextField> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
