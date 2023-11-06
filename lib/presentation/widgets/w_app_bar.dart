import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const WAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
        padding: const EdgeInsets.only(left: 12),
        child: IconButton(
          icon: SvgPicture.asset(
            SvgPaths.iconArrowLeft,
          ),
          onPressed: () {
            if (context.canPopBeamLocation) {
              context.popBeamLocation();
            }
          },
        ),
      ),
      elevation: 0.3,
      title: Text(
        title,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
