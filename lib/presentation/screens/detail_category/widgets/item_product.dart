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
  final Function(ProductEntity) onTapFavorite;

  const ItemProduct({
    super.key,
    required this.entity,
    required this.callback,
    required this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const horizontalPadding = 10.0;

    return GestureDetector(
      onTap: () {
        callback.call(entity.id);
      },
      child: Stack(
        alignment: Alignment.topRight,
        clipBehavior: Clip.antiAlias,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                width: size.width / 2,
                height: size.width / 2,
                memCacheWidth: (size.width / 2).round(),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: horizontalPadding),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: horizontalPadding),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: horizontalPadding),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: WReviews(
                  rating: entity.rating ?? 0,
                  numReviews: entity.numOfReviews ?? 0,
                ),
              ),
            ],
          ),
          Positioned(
            right: 7,
            top: 7,
            child: InkWell(
              onTap: () {
                onTapFavorite.call(entity);
              },
              child: entity.isFavorite ?? false
                  ? const Icon(
                      Icons.favorite_rounded,
                      size: 25,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_outline_rounded,
                      size: 25,
                      color: AppColors.textLightBasic,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
