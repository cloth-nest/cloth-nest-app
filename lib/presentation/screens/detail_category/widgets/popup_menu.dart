import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopupMenu extends StatelessWidget {
  final List<String> values;
  final String initValue;
  final Function(String)? callback;

  const PopupMenu({
    super.key,
    required this.values,
    required this.initValue,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: values
            .map((e) => _buildPopupMenuItem(e, initValue, context))
            .toList(),
      ),
    );
  }

  Widget _buildPopupMenuItem(String e, String initValue, BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback!(e);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              e,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: e == initValue
                        ? AppColors.iconActive
                        : AppColors.textLightBasic,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    height: 19.6 / 14,
                  ),
            ),
            const Spacer(),
            e == initValue
                ? SvgPicture.asset(SvgPaths.iconSelect)
                : SvgPicture.asset(SvgPaths.iconUnselect),
          ],
        ),
      ),
    );
  }
}
