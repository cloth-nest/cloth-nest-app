import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/product_detail/product_detail_view_factory.dart';
import 'package:ecommerce/app/routes/top/top_qr_location.dart';
import 'package:flutter/material.dart';

class TopQrProductLocation extends BeamLocation<BeamState> {
  TopQrProductLocation([super.routeInformation]);
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final topQrLocation = TopQrLocation();
    final pages = topQrLocation.buildPages(context, state);
    final int idProduct =
        int.parse(state.queryParameters['idProduct'].toString());

    return pages
      ..add(
        BeamPage(
          key: ValueKey('top-qr-detail-product-$idProduct'),
          child: makeProductDetailView(idProduct: idProduct),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/qr_code/product?idProduct=:idProduct'];
}
