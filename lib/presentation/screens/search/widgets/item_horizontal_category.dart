import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemHorizontalCategory extends StatelessWidget {
  final String category;
  final VoidCallback onTap;

  const ItemHorizontalCategory({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.lineBasic,
              width: 1,
            ),
          ),
        ),
        height: 50,
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          title: Text(
            category.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 14,
                  height: 21 / 14,
                ),
          ),
          trailing: SvgPicture.asset(
            SvgPaths.iconArrowRight,
            width: 30,
            height: 30,
            color: AppColors.iconGray,
          ),
        ),
      ),
    );
  }
}
