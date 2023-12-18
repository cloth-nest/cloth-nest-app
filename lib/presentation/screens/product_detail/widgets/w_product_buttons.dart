import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_bookmark_button.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_buy_now_button.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WProductButtons extends StatelessWidget {
  final double marginSide;
  final VoidCallback onTapFavorite;

  const WProductButtons({
    super.key,
    required this.marginSide,
    required this.onTapFavorite,
  });

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
            onClick: () {
              context.read<ProductDetailPresenter>().addToCart();
            },
          ),
          const SizedBox(width: 10),

          /// FAVORITE
          WProductBookmarkButton(
            buttonName: 'buttonName',
            onClick: () {
              onTapFavorite.call();
            },
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
