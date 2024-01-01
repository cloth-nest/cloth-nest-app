import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/widgets/dialog/dialog_one_button.dart';
import 'package:ecommerce/app/utils/singleton/user_token_singleton.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_bookmark_button.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_buy_now_button.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WProductButtons extends StatelessWidget {
  final double marginSide;
  final VoidCallback onTapFavorite;
  final VoidCallback onBuyNow;

  const WProductButtons({
    super.key,
    required this.marginSide,
    required this.onTapFavorite,
    required this.onBuyNow,
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
              onClick: () {
                onBuyNow.call();
              },
            ),
          ),
          const SizedBox(width: 10),

          /// ADD TO CART
          WProductCartButton(
            buttonName: 'buttonName',
            onClick: () {
              final isAuthenticated =
                  UserTokenSingleton().latestUserSession != null;

              if (isAuthenticated) {
                context.read<ProductDetailPresenter>().addToCart();
              } else {
                dialogOneButton(
                  context,
                  title: 'Log in',
                  content:
                      'When you log in to ClothNest!, you can create a list of your products and can buy later',
                  buttonOne: 'Login',
                  buttonOneTap: () {
                    Beamer.of(context, root: true).beamToReplacementNamed(
                      '/login',
                    );
                  },
                );
                return;
              }
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
        ],
      ),
    );
  }
}
