import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/product_detail/product_detail_view_factory.dart';
import 'package:ecommerce/app/routes/top/top_category_location.dart';
import 'package:flutter/material.dart';

class TopProductLocation extends BeamLocation<BeamState> {
  TopProductLocation([super.routeInformation]);
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final topLocation = TopCategoryLocation();
    final pages = topLocation.buildPages(context, state);
    final int idProduct = int.parse(state.queryParameters['idProduct'] ?? '-1');

    return pages
      ..add(
        BeamPage(
            key: const ValueKey('top-detail-product'),
            child: makeProductDetailView(idProduct: idProduct)),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/product?idProduct=:idProduct'];
}
