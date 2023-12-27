import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/presentation/screens/qr_code/qr_code_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalListProducts extends StatelessWidget {
  final List<ProductEntity> products;

  const HorizontalListProducts({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  color: AppColors.placeholderLightMode,
                  child: CachedNetworkImage(
                    imageUrl: products[index].image,
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
                ),
                Positioned(
                  right: 7,
                  top: 7,
                  child: InkWell(
                    onTap: () {
                      if (products[index].isFavorite ?? false) {
                        context
                            .read<QrCodePresenter>()
                            .removeFromWishList(product: products[index]);
                      } else {
                        context
                            .read<QrCodePresenter>()
                            .addToWishList(product: products[index]);
                      }
                    },
                    child: products[index].isFavorite ?? false
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
        },
      ),
    );
  }
}
