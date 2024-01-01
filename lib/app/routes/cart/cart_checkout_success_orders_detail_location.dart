import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/order_detail/order_detail_factory.dart';
import 'package:ecommerce/app/factories/presentation/order_detail/order_detail_presenter_factory.dart';
import 'package:ecommerce/app/routes/cart/cart_checkout_success_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCheckOutSuccessOrdersDetailLocation extends BeamLocation<BeamState> {
  CartCheckOutSuccessOrdersDetailLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final orderLocation = CartCheckOutSuccessLocation();
    final pages = orderLocation.buildPages(context, state);

    final int idOrder = int.parse(state.queryParameters['idOrder'] ?? '1');

    return pages
      ..add(
        BeamPage(
          key: const ValueKey('check-out-success-orders-detail'),
          title: 'order',
          child: ChangeNotifierProvider(
            create: (_) => makeOrderDetailPresenter(),
            child: makeOrderDetailView(idOrder: idOrder),
          ),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/detail?idOrder=:idOrder'];
}
