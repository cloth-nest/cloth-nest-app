import 'dart:io';

import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_themes.dart';
import 'package:ecommerce/presentation/widgets/text_field/base_text_field.dart';
import 'package:flutter/material.dart';

class NormalTextField extends BaseTextField {
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
    super.keyboardType = TextInputType.emailAddress,
  });

  @override
  State<NormalTextField> createState() => BTextFieldState();
}

class BTextFieldState extends State<NormalTextField> {
  String get _placeholder => widget.placeHolder;

  Widget? get _iconPrefixWidget => widget.prefixIcon;

  TextInputType? get _keyboardType => widget.keyboardType;

  bool get _autoFocus => widget.autoFocus;

  TextInputAction? get _textInputAction => widget.textInputAction;

  FocusNode? get _focusNode => widget.focusNode;

  FocusNode? get _nextFocusNode => widget.nextFocus;

  Function(String? textChanged)? get _onChanged => widget.onChanged;

  Function(String? textSubmitted)? get _onSubmitted => widget.onSubmitted;

  Function(bool? hasFocus)? get _onFocusChanged => widget.onFocusChanged;

  final TextStyle _textStyle =
      AppThemes.lightTheme.textTheme.headlineMedium!.copyWith(
    fontWeight: FontWeight.w300,
  );

  String? get _errorText => widget.errorText;

  TextEditingController get _controller => widget.controller;

  final ValueNotifier<bool> _isEmptyNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    _focusNode?.addListener(
      _focusChangedListener,
    );
    _controller.addListener(_controllerTextChange);
  }

  void _focusChangedListener() {
    _onFocusChanged?.call(_focusNode?.hasFocus);
  }

  void _controllerTextChange() {
    _isEmptyNotifier.value = _controller.text.isEmpty;
  }

  @override
  void dispose() {
    _controller.removeListener(_controllerTextChange);
    _focusNode?.removeListener(_focusChangedListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder<bool>(
            valueListenable: _isEmptyNotifier,
            builder: (context, isEmpty, child) {
              return TextField(
                controller: _controller,
                keyboardType: _keyboardType,
                autocorrect: false,
                focusNode: _focusNode,
                onChanged: _onChanged,
                autofocus: _autoFocus,
                onSubmitted: (text) {
                  if (_nextFocusNode != null) {
                    FocusScope.of(context).requestFocus(_nextFocusNode);
                  }
                  _onSubmitted?.call(text);
                },
                style: _textStyle.copyWith(color: AppColors.textLightBasic),
                textInputAction: _textInputAction,
                decoration: InputDecoration(
                  contentPadding: Platform.isIOS
                      ? const EdgeInsets.fromLTRB(10, -10, 50, -10)
                      : const EdgeInsets.fromLTRB(10, -5, 50, 32),
                  prefixIcon: _iconPrefixWidget,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      color: isEmpty
                          ? AppColors.lineBasic
                          : AppColors.skyPerfectBlue,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: const BorderSide(
                        color: AppColors.skyPerfectBlue, width: 1),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(minHeight: 30, minWidth: 30),
                  hintText: _placeholder,
                  errorText: _errorText,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
