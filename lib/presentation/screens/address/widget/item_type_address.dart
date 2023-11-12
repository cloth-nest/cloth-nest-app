import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ItemTypeAddress extends StatelessWidget {
  final String typeAddress;
  final Widget leading;
  final VoidCallback onTap;
  final Widget? trailing;

  const ItemTypeAddress({
    super.key,
    required this.typeAddress,
    required this.leading,
    required this.onTap,
    this.trailing,
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
          leading: leading,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          title: Text(
            typeAddress,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 14,
                  height: 21 / 14,
                  fontWeight: FontWeight.w600,
                ),
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
