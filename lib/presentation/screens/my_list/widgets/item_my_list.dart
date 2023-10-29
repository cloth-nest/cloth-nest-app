import 'package:ecommerce/presentation/screens/my_list/widgets/img_wishlist.dart';
import 'package:ecommerce/presentation/screens/my_list/widgets/info_wishlist.dart';
import 'package:flutter/material.dart';

class ItemMyList extends StatelessWidget {
  const ItemMyList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        bottom: 10,
        top: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImgWishlist(),
          SizedBox(width: 20),
          InfoWishlist(),
        ],
      ),
    );
  }
}
