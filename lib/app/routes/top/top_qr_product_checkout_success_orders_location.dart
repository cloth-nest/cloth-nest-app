import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/order/order_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/order/order_view_factory.dart';
import 'package:ecommerce/app/routes/cart/cart_checkout_success_location.dart';
import 'package:ecommerce/app/routes/top/top_qr_product_checkout_success_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopQrProductCheckOutSuccessOrdersLocation
    extends BeamLocation<BeamState> {
  TopQrProductCheckOutSuccessOrdersLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final cartCheckOutLocation = TopQrProductCheckOutSuccessLocation();
    final pages = cartCheckOutLocation.buildPages(context, state);

    return pages
      ..add(
        BeamPage(
          key: const ValueKey('check-out-success-orders'),
          child: ChangeNotifierProvider(
            create: (_) => makeOrderPresenter(),
            child: makeOrderView(isCanBack: true),
          ),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/orders'];
}
