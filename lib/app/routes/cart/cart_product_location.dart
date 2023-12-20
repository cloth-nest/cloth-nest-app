import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/product_detail/product_detail_view_factory.dart';
import 'package:ecommerce/app/routes/cart/cart_location.dart';
import 'package:flutter/material.dart';

class CartProductLocation extends BeamLocation<BeamState> {
  CartProductLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final cartLocation = CartLocation();
    final pages = cartLocation.buildPages(context, state);

    final int idProduct =
        int.parse(state.queryParameters['idProduct'].toString());

    return pages
      ..add(
        BeamPage(
          key: ValueKey('cart-product-$idProduct'),
          child: makeProductDetailView(idProduct: idProduct),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/product?idProduct=:idProduct'];
}
