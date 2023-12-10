import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/utils/extensions/double_extension.dart';
import 'package:ecommerce/app/utils/extensions/theme_extension.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:flutter/material.dart';

class WProduct extends StatelessWidget {
  final ProductEntity entity;

  const WProduct({
    super.key,
    required this.entity,
  });

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
                          imageUrl: entity.image,
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
                  entity.name,
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  entity.price.toMoney(),
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
