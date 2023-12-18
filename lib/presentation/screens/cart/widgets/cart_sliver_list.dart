import 'package:beamer/beamer.dart';
import 'package:ecommerce/domain/entities/cart/cart_entity.dart';
import 'package:ecommerce/presentation/screens/cart/cart_presenter.dart';
import 'package:ecommerce/presentation/screens/cart/widgets/w_item_cart.dart';
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
                childCount: carts.length,
              ),
            ),
    );
  }
}
