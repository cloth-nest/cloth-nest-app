import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/check_out/check_out_view_factory.dart';
import 'package:ecommerce/app/factories/presentation/check_out/checkout_presenter_factory.dart';
import 'package:ecommerce/app/routes/search/search_detail_category_product_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchDetailCategoryProductCheckoutLocation
    extends BeamLocation<BeamState> {
  SearchDetailCategoryProductCheckoutLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final topProductLocation = SearchDetailCategoryProductLocation();
    final pages = topProductLocation.buildPages(context, state);

    final int variantId = int.parse(state.queryParameters['variantId'] ?? '-1');

    return pages
      ..add(
        BeamPage(
          key: ValueKey('top-product-checkout-$variantId'),
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
