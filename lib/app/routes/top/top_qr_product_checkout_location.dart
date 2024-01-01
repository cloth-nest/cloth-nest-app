import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/check_out/check_out_view_factory.dart';
import 'package:ecommerce/app/factories/presentation/check_out/checkout_presenter_factory.dart';
import 'package:ecommerce/app/routes/top/top_qr_product_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopQrProductCheckOutLocation extends BeamLocation<BeamState> {
  TopQrProductCheckOutLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final topProductLocation = TopQrProductLocation();
    final pages = topProductLocation.buildPages(context, state);

    final int variantId = int.parse(state.queryParameters['variantId'] ?? '-1');

    return pages
      ..add(
        BeamPage(
          key: ValueKey('top-qr-product-checkout-$variantId'),
          child: ChangeNotifierProvider(
            create: (_) => makeCheckOutPresenter(),
            child: makeCheckOutView(variantId),
          ),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/checkout?variantId=:variantId'];
}
