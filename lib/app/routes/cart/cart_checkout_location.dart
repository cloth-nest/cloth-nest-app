import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/check_out/check_out_view_factory.dart';
import 'package:ecommerce/app/factories/presentation/check_out/checkout_presenter_factory.dart';
import 'package:ecommerce/app/routes/cart/cart_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCheckOutLocation extends BeamLocation<BeamState> {
  CartCheckOutLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final cartLocation = CartLocation();
    final pages = cartLocation.buildPages(context, state);

    return pages
      ..add(
        BeamPage(
          key: const ValueKey('check-out'),
          child: ChangeNotifierProvider(
            create: (_) => makeCheckOutPresenter(),
            child: makeCheckOutView(),
          ),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/check_out'];
}
