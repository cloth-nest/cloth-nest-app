import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/review/review_order_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/review/review_order_view_factory.dart';
import 'package:ecommerce/app/routes/order/order_detail_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailReviewLocation extends BeamLocation<BeamState> {
  OrderDetailReviewLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final orderLocation = OrderDetailLocation();
    final pages = orderLocation.buildPages(context, state);

    final int idProduct = int.parse(state.queryParameters['idProduct'] ?? '1');

    return pages
      ..add(
        BeamPage(
          key: const ValueKey('order-detail-review'),
          title: 'order',
          child: ChangeNotifierProvider(
            create: (_) => makeReviewOrderPresenter(),
            child: makeReviewOrderView(idProduct: idProduct),
          ),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/review?idProduct=:idProduct'];
}
