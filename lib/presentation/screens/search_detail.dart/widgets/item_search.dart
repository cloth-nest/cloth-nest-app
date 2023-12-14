import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/presentation/screens/my_list/widgets/info_wishlist.dart';
import 'package:ecommerce/presentation/screens/search_detail.dart/search_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/search_detail.dart/widgets/img_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemSearch extends StatelessWidget {
  final Function(ProductEntity) onTap;
  final ProductEntity entity;

  const ItemSearch({
    super.key,
    required this.onTap,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call(entity);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          bottom: 10,
          top: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImgSearch(
              imageUrl: entity.image,
              onTapFavorite: () {
                if (entity.isFavorite ?? false) {
                  context
                      .read<SearchDetailPresenter>()
                      .removeFromWishList(product: entity);
                } else {
                  context
                      .read<SearchDetailPresenter>()
                      .addToWishList(product: entity);
                }
              },
              isFavorite: entity.isFavorite ?? false,
            ),
            const SizedBox(width: 20),
            InfoWishlist(
              entity: entity,
            ),
          ],
        ),
      ),
    );
  }
}
