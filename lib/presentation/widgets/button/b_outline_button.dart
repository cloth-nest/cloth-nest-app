import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/widgets/button/base_button.dart';
import 'package:flutter/material.dart';

class BOutlineButton extends BaseButton {
  const BOutlineButton({
    super.key,
    required super.buttonName,
    required super.onClick,
    super.contentPadding,
    super.prefixIcon,
    super.suffixIcon,
    super.isActive,
    super.textStyle,
    super.maxLines,
    this.widthSizeBox = 0,
  });

  final double? widthSizeBox;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isActive ? onClick : null,
      style: OutlinedButton.styleFrom(
        padding: contentPadding,
        side: const BorderSide(
          width: 1,
          color: AppColors.lineBasic,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixIcon != null ? prefixIcon! : const SizedBox.shrink(),
          Flexible(
            child: Text(
              buttonName,
              maxLines: 1,
              style: textStyle ?? Theme.of(context).textTheme.labelLarge,
            ),
          ),
          SizedBox(width: widthSizeBox),
          suffixIcon != null ? suffixIcon! : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
