import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemFilter extends StatelessWidget {
  final String filter;
  final VoidCallback callback;
  final bool isActive;

  const ItemFilter({
    super.key,
    required this.filter,
    required this.callback,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? AppColors.lineBasic : AppColors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isActive ? AppColors.textLightBasic : AppColors.lineBasic,
          ),
        ),
        padding: const EdgeInsets.only(
          left: 15,
          top: 5,
          bottom: 5,
          right: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              filter,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 13,
                    //height: 21 / 13,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SvgPicture.asset(
              SvgPaths.iconArrowDown,
              width: 30,
              height: 30,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
