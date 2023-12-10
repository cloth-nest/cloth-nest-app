import 'dart:io';

import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WProductBadge extends StatelessWidget {
  const WProductBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = context.read<ProductDetailPresenter>();

    return Selector<ProductDetailPresenter, int>(
      selector: (_, presenter) => presenter.tabIndex,
      builder: (_, tabIndex, __) => Container(
        width: 30.0,
        height: 30.0,
        padding: const EdgeInsets.all(1),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: tabIndex == 0
              ? AppColors.skyPerfectBlue
              : AppColors.backgroundDarkMode,
          borderRadius: BorderRadius.circular(36),
        ),
        child: Text(
          presenter.recommendationProducts.length.toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                height: Platform.isIOS ? 1.3 : 1,
                color: AppColors.white,
                fontSize: 11,
              ),
        ),
      ),
    );
  }
}
