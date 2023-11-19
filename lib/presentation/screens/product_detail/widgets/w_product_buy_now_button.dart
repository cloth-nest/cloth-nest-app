import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class WProductBuyNowButton extends StatelessWidget {
  final VoidCallback onClick;
  const WProductBuyNowButton({
    super.key,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onClick,
      style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.white,
          minimumSize: const Size.fromHeight(45),
          disabledBackgroundColor: AppColors.iconDisabled,
          backgroundColor: AppColors.iconLightBasic,
          side: BorderSide.none,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          )),
      child: AutoSizeText(
        maxLines: 1,
        'Buy Now',
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: AppColors.white),
      ),
    );
  }
}
