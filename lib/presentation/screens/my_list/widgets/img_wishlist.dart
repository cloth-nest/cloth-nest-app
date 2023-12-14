import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ImgWishlist extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onDelete;

  const ImgWishlist({
    super.key,
    required this.imageUrl,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        CachedNetworkImage(
          width: 120,
          height: 120,
          imageUrl: imageUrl,
          fit: BoxFit.contain,
          placeholder: (context, url) => Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.placeholderLightMode,
            ),
          ),
          errorWidget: (context, url, error) {
            return Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: AppColors.placeholderLightMode,
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 5),
          child: InkWell(
            onTap: () {
              onDelete.call();
            },
            child: const Icon(
              Icons.favorite_rounded,
              color: Colors.red,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
