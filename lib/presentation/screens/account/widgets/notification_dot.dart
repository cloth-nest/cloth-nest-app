import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationDot extends StatelessWidget {
  final double size;

  const NotificationDot({
    super.key,
    this.size = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.accentCTA,
      ),
    );
  }
}
