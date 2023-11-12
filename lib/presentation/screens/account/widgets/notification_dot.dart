import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationDot extends StatelessWidget {
  const NotificationDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.accentCTA,
      ),
    );
  }
}
