import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_bookmark_button.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_buy_now_button.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_cart_button.dart';
import 'package:flutter/material.dart';

class WProductButtons extends StatelessWidget {
  final double marginSide;

  const WProductButtons({super.key, required this.marginSide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: marginSide,
        right: marginSide,
        bottom: 10,
      ),
      child: Row(
        children: [
          /// BUY NOW
          Expanded(
            child: WProductBuyNowButton(
              onClick: () {},
            ),
          ),
          const SizedBox(width: 10),

          /// ADD TO CART
          WProductCartButton(
            buttonName: 'buttonName',
            onClick: () {},
          ),
          const SizedBox(width: 10),

          /// FAVORITE
          WProductBookmarkButton(
            buttonName: 'buttonName',
            onClick: () {},
          ),

          // Expanded(
          //   child: WBookmarkButton(
          //     marginSide: marginSide,
          //   ),
          // ),
          // WCalendarButton(
          //   marginSide: marginSide,
          // ),
        ],
      ),
    );
  }
}
