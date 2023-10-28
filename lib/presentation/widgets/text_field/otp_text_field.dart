import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_themes.dart';
import 'package:ecommerce/presentation/widgets/text_field/base_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpTextField extends BaseTextField {
  const OtpTextField({
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
  State<OtpTextField> createState() => BTextFieldState();
}

class BTextFieldState extends State<OtpTextField> {
  TextInputAction? get _textInputAction => widget.textInputAction;

  bool get _autoFocus => widget.autoFocus;

  FocusNode? get _focusNode => widget.focusNode;

  FocusNode? get _nextFocusNode => widget.nextFocus;

  Function(String? textChanged)? get _onChanged => widget.onChanged;

  Function(String? textSubmitted)? get _onSubmitted => widget.onSubmitted;

  Function(bool? hasFocus)? get _onFocusChanged => widget.onFocusChanged;

  final TextStyle _textStyle =
      AppThemes.lightTheme.textTheme.headlineMedium!.copyWith(
    fontWeight: FontWeight.w300,
  );

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
    return ValueListenableBuilder<bool>(
      valueListenable: _isEmptyNotifier,
      builder: (context, isEmpty, child) {
        return TextField(
          textAlign: TextAlign.center,
          controller: _controller,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number,
          autocorrect: false,
          //focusNode: _focusNode,
          onChanged: (text) {
            _onChanged?.call(text);
          },
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
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(
                color: isEmpty ? AppColors.lineBasic : AppColors.skyPerfectBlue,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide:
                  const BorderSide(color: AppColors.skyPerfectBlue, width: 1),
            ),
          ),
        );
      },
    );
  }
}
