import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/product_detail/product_detail_view_factory.dart';
import 'package:ecommerce/app/routes/search/search_detail_location.dart';
import 'package:flutter/material.dart';

class SearchDetailProductLocation extends BeamLocation<BeamState> {
  SearchDetailProductLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final searchDetailLocation = SearchDetailLocation();
    final pages = searchDetailLocation.buildPages(context, state);

    final int idProduct =
        int.parse(state.queryParameters['idProduct'].toString());

    return pages
      ..add(
        BeamPage(
          key: ValueKey('search-detail-product-$idProduct'),
          child: makeProductDetailView(idProduct: idProduct),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/product?idProduct=:idProduct'];
}
