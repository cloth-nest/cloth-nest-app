import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/domain/entities/cart/cart_entity.dart';
import 'package:ecommerce/presentation/screens/cart/cart_presenter.dart';
import 'package:ecommerce/presentation/screens/cart/widgets/w_item_cart.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSliverList extends StatelessWidget {
  const CartSliverList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<CartPresenter, List<CartEntity>>(
      selector: (_, presenter) => presenter.carts,
      builder: (_, carts, __) => carts.isEmpty
          ? SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'There is no item cart',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            )
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == carts.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: BRoundButton(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 11),
                        buttonName: 'Checkout',
                        onClick: () {
                          beamTo(context, path: 'check_out');
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        customTextStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    );
                  }
                  return WItemCart(
                    onTap: () {
                      final String currentLocation = context.currentBeamLocation
                              .state.routeInformation.location ??
                          '/';
                      final uri = Uri.parse(currentLocation);
                      context.beamToNamed(
                          '${uri.path}/product?idProduct=${carts[index].productId}');
                    },
                    cart: carts[index],
                  );
                },
                childCount: carts.length + 1,
              ),
            ),
    );
  }
}
