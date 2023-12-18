import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/utils/extensions/double_extension.dart';
import 'package:ecommerce/domain/entities/cart/cart_entity.dart';
import 'package:ecommerce/presentation/screens/cart/cart_presenter.dart';
import 'package:ecommerce/presentation/screens/cart/widgets/w_icon_edit_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WItemCart extends StatelessWidget {
  final CartEntity cart;
  final VoidCallback onTap;

  const WItemCart({
    super.key,
    required this.cart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 10.0,
          right: 20,
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: cart.image,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cart.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    cart.price.toMoney(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                WIconEditCart(
                  child: const Positioned(
                    bottom: 7,
                    child: Icon(
                      Icons.minimize,
                      size: 17,
                      color: AppColors.skyPerfectBlue,
                    ),
                  ),
                  callback: () {
                    context
                        .read<CartPresenter>()
                        .removeFromCart(variantId: cart.variantId);
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  '${cart.quantity}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(width: 10),
                WIconEditCart(
                  child: const Icon(
                    Icons.add,
                    size: 17,
                    color: AppColors.skyPerfectBlue,
                  ),
                  callback: () {
                    context
                        .read<CartPresenter>()
                        .addToCart(variantId: cart.variantId);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
