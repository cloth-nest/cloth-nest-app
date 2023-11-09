import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/app/resources/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonEdit extends StatelessWidget {
  final VoidCallback onTap;

  const ButtonEdit({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 152 / 2,
        decoration: const BoxDecoration(
          color: Color(
            0xFFE5E5E5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              SvgPaths.iconEdit,
              width: 24,
              height: 24,
            ),
            const SizedBox(height: 3),
            Text(
              'Edit',
              style: AppThemes.lightTheme.textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
