import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/presentation/widgets/button/base_button.dart';
import 'package:flutter/material.dart';

class WProductCartButton extends BaseButton {
  const WProductCartButton({
    super.key,
    required super.buttonName,
    required super.onClick,
  });

  @override
  Widget build(BuildContext context) {
    const double iconButtonSize = 11.0;
    const double buttonContainerSize = 48.0;
    return OutlinedButton(
      onPressed: isActive ? onClick : null,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          width: 1,
          color: AppColors.lineBasic,
        ),
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: SizedBox(
        width: buttonContainerSize,
        height: buttonContainerSize,
        child: Padding(
          padding: const EdgeInsets.all(iconButtonSize),
          child: Image.asset(
            SvgPaths.iconCart,
            height: iconButtonSize,
            width: iconButtonSize,
          ),
        ),
      ),
    );
  }
}
