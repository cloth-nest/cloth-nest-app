import 'package:ecommerce/presentation/screens/my_list/widgets/img_wishlist.dart';
import 'package:ecommerce/presentation/screens/my_list/widgets/info_wishlist.dart';
import 'package:flutter/material.dart';

class ItemMyList extends StatelessWidget {
  final VoidCallback onTap;

  const ItemMyList({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
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
              callback: () => onTap.call(),
            ),
            const SizedBox(width: 20),
            const InfoWishlist(),
          ],
        ),
      ),
    );
  }
}
