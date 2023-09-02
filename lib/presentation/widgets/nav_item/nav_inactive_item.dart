import 'package:ecommerce/presentation/widgets/icon.dart';
import 'package:flutter/material.dart';
import 'base_nav_item.dart';

class NavInactiveItem extends BaseNavItem {
  const NavInactiveItem(
    Key? key,
    this._label, {
    required String iconPath,
    required String defaultIconColor,
  }) : super(
          key: key,
          iconPath: iconPath,
          defaultIconColor: defaultIconColor,
        );
  final String _label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight,
      child: Column(
        children: [
          PrimaryIcon(
            defaultColor: defaultIconColor,
            icon: iconPath,
          ),
          Text(_label, style: Theme.of(context).textTheme.bodyLarge)
        ],
      ),
    );
  }
}
