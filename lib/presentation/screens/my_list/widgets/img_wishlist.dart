import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ImgWishlist extends StatelessWidget {
  const ImgWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        CachedNetworkImage(
          width: 120,
          height: 120,
          imageUrl:
              'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/462770/item/vngoods_56_462770.jpg?width=250',
          fit: BoxFit.contain,
          placeholder: (context, url) => Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.placeholderLightMode,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5, right: 5),
          child: Icon(
            Icons.favorite_rounded,
            color: Colors.red,
            size: 20,
          ),
        ),
      ],
    );
  }
}
