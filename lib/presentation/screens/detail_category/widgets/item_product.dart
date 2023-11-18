import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/horizontal_list_color.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/w_gender_size.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/w_reviews.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatelessWidget {
  // final String category;
  // final VoidCallback onTap;
  // final String? categoryThumbUrl;

  const ItemProduct({
    super.key,
    // required this.category,
    // required this.onTap,
    // required this.categoryThumbUrl,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const horizontalPadding = 10.0;

    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            width: size.width / 2,
            height: size.width / 2,
            imageUrl:
                'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/464022/item/vngoods_03_464022.jpg?width=320',
            fit: BoxFit.fitHeight,
            placeholder: (context, url) => Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.placeholderLightMode,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: HorizontalListColor(
              colors: [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.cyan,
                Colors.orange,
              ],
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
              'Pocketable UV Protection Parka',
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
              '489.000 VND',
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
