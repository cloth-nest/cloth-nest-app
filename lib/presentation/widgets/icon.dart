import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryIcon extends StatelessWidget {
  final defaultStringSvg =
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1 1"></svg>';

  /// Default color and size of icon in file svg
  final String defaultColor;

  /// Path to icon svg file
  final String icon;

  /// Color of icon
  final Color color;

  /// width of icon
  final double width;

  /// height of icon
  final double height;

  /// Fit of icon
  final BoxFit fit;

  // if you want change color of svg
  final Color? subColor;

  const PrimaryIcon({
    super.key,
    required this.icon,
    required this.defaultColor,
    this.color = AppColors.iconLightBasic,
    this.width = 30,
    this.height = 30,
    this.fit = BoxFit.none,
    this.subColor,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString(icon),
      builder: (context, snapshot) {
        return SizedBox(
          width: width,
          height: height,
          child: SvgPicture.string(
            (snapshot.data ?? defaultStringSvg),
            colorFilter: subColor == null
                ? null
                : ColorFilter.mode(subColor!, BlendMode.srcIn),
            width: width,
            height: height,
            fit: fit,
          ),
        );
      },
    );
  }
}
