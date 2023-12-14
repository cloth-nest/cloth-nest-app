import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/presentation/screens/my_list/my_list_presenter.dart';
import 'package:ecommerce/presentation/screens/my_list/widgets/img_wishlist.dart';
import 'package:ecommerce/presentation/screens/my_list/widgets/info_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemMyList extends StatelessWidget {
  final Function(ProductEntity) onTap;
  final ProductEntity entity;

  const ItemMyList({
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
            ImgWishlist(
              imageUrl: entity.image,
              onDelete: () {
                context
                    .read<MyListPresenter>()
                    .removeFromWishlist(entity: entity);
              },
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
