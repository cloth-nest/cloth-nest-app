import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonLogout extends StatelessWidget {
  final VoidCallback onTap;
  const ButtonLogout({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 200,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.lineBasic),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(SvgPaths.iconLogout),
              Text(
                'Log out',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 14,
                      height: 21 / 14,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
