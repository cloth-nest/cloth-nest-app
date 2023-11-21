import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ItemVerticalCategory extends StatelessWidget {
  final String category;
  final VoidCallback onTap;
  final String? categoryThumbUrl;

  const ItemVerticalCategory({
    super.key,
    required this.category,
    required this.onTap,
    required this.categoryThumbUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: categoryThumbUrl ??
                  'https://im.uniqlo.com/global-cms/spa/resfdbc5fee0d30385f4c2394e5d5aebac3fr.jpg',
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
          ),
          const SizedBox(height: 5),
          Text(
            category.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 1,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 13,
                  height: 21 / 13,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
