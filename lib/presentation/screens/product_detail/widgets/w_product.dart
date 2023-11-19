import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class WProduct extends StatelessWidget {
  const WProduct({super.key});

  @override
  Widget build(BuildContext context) {
    const widthItemProductDesign = 90 * 16 / 9;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: widthItemProductDesign,
              height: 90,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: Theme.of(context)
                          .extension<ExtensionColors>()!
                          .placeholder,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://bizweb.dktcdn.net/100/467/832/products/1-2f279636-9103-41d4-9762-62537cd8625b.jpg?v=1697874445763',
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  'DC x BR Mate T-shirt - Black',
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '390.000₫',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        height: 16.71 / 14,
                        color: AppColors.textGray999,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
