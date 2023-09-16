import 'dart:io';

import 'package:ecommerce/presentation/widgets/text_field/base_text_field.dart';
import 'package:flutter/material.dart';

import '../../../app/resources/app_colors.dart';
import '../../../app/resources/app_themes.dart';
import '../icon.dart';

class PasswordTextField extends BaseTextField {
  const PasswordTextField({
    super.key,
    required super.placeHolder,
    super.prefixIcon,
    super.onChanged,
    super.onSubmitted,
    super.autoFocus,
    super.errorText,
    super.focusNode,
    super.nextFocus,
    required super.controller,
    super.textInputAction = TextInputAction.done,
    required this.isObscureText,
    this.suffixIconPath,
    this.onSuffixIconClicked,
  });

  final bool isObscureText;
  final String? suffixIconPath;
  final VoidCallback? onSuffixIconClicked;

  @override
  State<PasswordTextField> createState() => BTextFieldState();
}

class BTextFieldState extends State<PasswordTextField> {
  String get _placeholder => widget.placeHolder;

  Widget? get _iconPrefixWidget => widget.prefixIcon;

  String? get _iconSuffixPath => widget.suffixIconPath;

  bool get _autoFocus => widget.autoFocus;

  bool get _isObscureText => widget.isObscureText;

  String? get _errorText => widget.errorText;

  TextInputAction? get _textInputAction => widget.textInputAction;

  FocusNode? get _focusNode => widget.focusNode;

  FocusNode? get _nextFocusNode => widget.nextFocus;

  Function(String? textChanged)? get _onChanged => widget.onChanged;

  Function(String? textSubmitted)? get _onSubmitted => widget.onSubmitted;

  Function(bool? hasFocus)? get _onFocusChanged => widget.onFocusChanged;

  VoidCallback? get _onSuffixIconClicked => widget.onSuffixIconClicked;

  final TextStyle _textStyle =
      AppThemes.lightTheme.textTheme.headlineMedium!.copyWith(
    fontWeight: FontWeight.w300,
  );

  TextEditingController get _controller => widget.controller;

  final ValueNotifier<bool> _isEmptyNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    _focusNode?.addListener(_focusChangedListener);
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
            builder: (context, isEmpty, child) => TextField(
              controller: _controller,
              autocorrect: false,
              focusNode: _focusNode,
              textInputAction: _textInputAction,
              onChanged: _onChanged,
              autofocus: _autoFocus,
              onSubmitted: (text) {
                if (_nextFocusNode != null) {
                  FocusScope.of(context).requestFocus(_nextFocusNode);
                }
                _onSubmitted?.call(text);
              },
              obscureText: _isObscureText,
              obscuringCharacter: '●',
              style: _textStyle,
              decoration: InputDecoration(
                contentPadding: Platform.isIOS
                    ? const EdgeInsets.fromLTRB(10, -10, 0, -10)
                    : const EdgeInsets.fromLTRB(10, 0, 0, 20),
                prefixIcon: _iconPrefixWidget,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: BorderSide(
                      color: isEmpty
                          ? AppColors.lineBasic
                          : AppColors.skyPerfectBlue,
                      width: 1),
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
                suffixIcon: _iconSuffixPath != null
                    ? InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        splashColor: AppColors.iconDisabled,
                        onTap: _onSuffixIconClicked,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: PrimaryIcon(
                            icon: _iconSuffixPath!,
                            defaultColor: '#CCCCCC',
                            color: AppColors.iconGray,
                            height: widget.prefixIconSize,
                            width: widget.prefixIconSize,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        )
      ],
    );
  }
}
