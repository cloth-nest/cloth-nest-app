import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:ecommerce/presentation/widgets/button/base_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WProductBookmarkButton extends BaseButton {
  const WProductBookmarkButton({
    super.key,
    required super.buttonName,
    required super.onClick,
  });

  @override
  Widget build(BuildContext context) {
    const double iconButtonSize = 25.0;
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
        child: Selector<ProductDetailPresenter, bool>(
          selector: (_, presenter) => presenter.isFavorite,
          builder: (_, isFavorite, __) => isFavorite
              ? const Icon(
                  Icons.favorite_rounded,
                  size: iconButtonSize,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.favorite_outline_rounded,
                  size: iconButtonSize,
                  color: AppColors.textLightBasic,
                ),
        ),
      ),
    );
  }
}
