import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/utils/extensions/theme_extension.dart';
import 'package:ecommerce/presentation/widgets/button/base_button.dart';
import 'package:flutter/material.dart';

class BRoundButton extends BaseButton {
  const BRoundButton({
    super.key,
    this.backgroundColor = AppColors.iconActive,
    required super.buttonName,
    required super.onClick,
    this.customTextStyle,
    this.borderRadius = 6,
    super.isActive,
    super.contentPadding =
        const EdgeInsets.symmetric(horizontal: 45, vertical: 11),
    super.contentAlign,
    super.textStyle,
    this.maxLineText = 1,
    this.maximumSize,
    this.minimumSize = const Size.fromHeight(45),
  });

  final double borderRadius;
  final Color backgroundColor;
  final TextStyle? customTextStyle;
  final int maxLineText;
  final Size? maximumSize;
  final Size? minimumSize;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: isActive ? onClick : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.white,
          minimumSize: minimumSize,
          maximumSize: maximumSize,
          disabledBackgroundColor: AppColors.iconDisabled,
          backgroundColor: backgroundColor,
          side: BorderSide.none,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Padding(
          padding: contentPadding ?? EdgeInsets.zero,
          child: Text(
            maxLines: maxLineText,
            buttonName,
            style: customTextStyle ??
                Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context)
                          .extension<ExtensionColors>()
                          ?.buttonTextActiveColor!,
                    ),
          ),
        ));
  }
}
