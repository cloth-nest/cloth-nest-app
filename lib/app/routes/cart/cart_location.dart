import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/cart/cart_view_factory.dart';
import 'package:flutter/material.dart';

class CartLocation extends BeamLocation<BeamState> {
  CartLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('cart'),
        title: 'Cart',
        child: makeCartView(),
      )
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/cart*'];
}
