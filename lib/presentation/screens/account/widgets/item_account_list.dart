import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ItemAccountList extends StatelessWidget {
  //final List<Map<String, dynamic>> contents;
  final List<Widget> children;

  const ItemAccountList({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundAccountList,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(children: children),
    );
  }
}
