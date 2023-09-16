import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/widgets/button/base_button.dart';
import 'package:flutter/material.dart';

class BTextButton extends BaseButton {
  const BTextButton({
    super.key,
    required super.buttonName,
    required super.onClick,
    super.contentPadding =
        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    super.prefixIcon,
    super.suffixIcon,
    super.isActive,
    super.contentAlign,
    super.textStyle,
    this.textAlign,
  });

  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isActive ? onClick : null,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Padding(
        padding: contentPadding ?? EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: contentAlign,
          children: [
            prefixIcon != null ? prefixIcon! : const SizedBox.shrink(),
            Flexible(
              child: Text(
                buttonName,
                textAlign: textAlign,
                style: textStyle ??
                    Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColors.skyPerfectBlue),
              ),
            ),
            suffixIcon != null ? suffixIcon! : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
