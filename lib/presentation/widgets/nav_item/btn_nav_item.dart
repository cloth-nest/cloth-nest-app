import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/widgets/nav_item/nav_active_item.dart';
import 'package:ecommerce/presentation/widgets/nav_item/nav_inactive_item.dart';
import 'package:flutter/material.dart';

class BtnNavItem extends StatelessWidget {
  const BtnNavItem({
    Key? key,
    required this.btnName,
    required this.iconPath,
    required this.isActive,
    this.defaultIconColor = '#222222',
  }) : super(key: key);
  final String btnName;
  final String iconPath;
  final bool isActive;
  final String defaultIconColor;

  final BoxShadow _boxShadow = const BoxShadow(
    offset: Offset(0, 10),
    blurRadius: 20,
    color: AppColors.boxShadowBottom,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: isActive ? 300 : 0),
          curve: Curves.easeInOut,
          width: isActive ? 50 : 0,
          height: isActive ? 50 : 0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.skyPerfectBlue,
            boxShadow: [_boxShadow],
          ),
        ),
        isActive
            ? Opacity(
                opacity: isActive ? 1 : 0,
                child: NavActiveItem(
                  key,
                  iconPath: iconPath,
                  defaultIconColor: defaultIconColor,
                  isActived: isActive,
                ),
              )
            : NavInactiveItem(
                key,
                btnName,
                iconPath: iconPath,
                defaultIconColor: defaultIconColor,
              ),
      ],
    );
  }
}
