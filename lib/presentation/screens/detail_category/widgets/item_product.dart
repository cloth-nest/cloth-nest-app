import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/utils/extensions/color_extension.dart';
import 'package:ecommerce/app/utils/extensions/double_extension.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/horizontal_list_color.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/w_gender_size.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/w_reviews.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatelessWidget {
  final Function(int) callback;
  final ProductEntity entity;

  const ItemProduct({
    super.key,
    required this.entity,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const horizontalPadding = 10.0;

    return GestureDetector(
      onTap: () {
        callback.call(entity.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            width: size.width / 2,
            height: size.width / 2,
            imageUrl: entity.image,
            fit: BoxFit.fitHeight,
            placeholder: (context, url) => Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.placeholderLightMode,
              ),
            ),
            errorWidget: (context, url, error) {
              return Container(
                decoration: const BoxDecoration(
                  color: AppColors.placeholderLightMode,
                ),
              );
            },
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: HorizontalListColor(
              colors: entity.colors?.toListColor() ?? [],
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: WGenderSize(category: 'Men', size: 'XS-XXL'),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              entity.name,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 14,
                    height: 19.6 / 14,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              entity.price.toMoney(),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 14,
                    height: 19.6 / 14,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: WReviews(
              rating: 5,
              numReviews: 7,
            ),
          ),
        ],
      ),
    );
  }
}
