import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ImgSearch extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTapFavorite;
  final bool isFavorite;

  const ImgSearch({
    super.key,
    required this.imageUrl,
    required this.onTapFavorite,
    required this.isFavorite,
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
              onTapFavorite.call();
            },
            child: isFavorite
                ? const Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                    size: 20,
                  )
                : const Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
          ),
        ),
      ],
    );
  }
}
