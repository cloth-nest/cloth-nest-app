import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/product_detail/product_detail_view_factory.dart';
import 'package:ecommerce/app/routes/search/search_detail_category_location.dart';
import 'package:flutter/material.dart';

class SearchDetailCategoryProductLocation extends BeamLocation<BeamState> {
  SearchDetailCategoryProductLocation([super.routeInformation]);
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final topLocation = SearchDetailCategoryLocation();
    final pages = topLocation.buildPages(context, state);
    final int idProduct = int.parse(state.queryParameters['idProduct'] ?? '-1');

    return pages
      ..add(
        BeamPage(
            key: const ValueKey('search-detail-product'),
            child: makeProductDetailView(idProduct: idProduct)),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/product?idProduct=:idProduct'];
}
