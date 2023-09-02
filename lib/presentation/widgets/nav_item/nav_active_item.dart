import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/widgets/icon.dart';
import 'package:flutter/material.dart';
import 'base_nav_item.dart';

class NavActiveItem extends BaseNavItem {
  final bool isActived;
  const NavActiveItem(
    Key? key, {
    required String iconPath,
    required String defaultIconColor,
    required this.isActived,
  }) : super(
          key: key,
          iconPath: iconPath,
          defaultIconColor: defaultIconColor,
        );

  @override
  Widget build(BuildContext context) {
    return PrimaryIcon(
      width: 30,
      height: 30,
      defaultColor: defaultIconColor,
      icon: iconPath,
      color: AppColors.white,
    );
  }
}
