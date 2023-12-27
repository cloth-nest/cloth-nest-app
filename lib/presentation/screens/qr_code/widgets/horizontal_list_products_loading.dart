import 'package:ecommerce/app/resources/app_colors.dart';

import 'package:flutter/material.dart';

class HorizontalListProductsLoading extends StatelessWidget {
  const HorizontalListProductsLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              width: 120,
              height: 120,
              color: AppColors.placeholderLightMode,
            ),
          );
        },
      ),
    );
  }
}
