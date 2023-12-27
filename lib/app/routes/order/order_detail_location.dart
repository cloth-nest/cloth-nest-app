import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/order_detail/order_detail_factory.dart';
import 'package:ecommerce/app/factories/presentation/order_detail/order_detail_presenter_factory.dart';
import 'package:ecommerce/app/routes/order/order_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailLocation extends BeamLocation<BeamState> {
  OrderDetailLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final orderLocation = OrderLocation();
    final pages = orderLocation.buildPages(context, state);

    final int idOrder = int.parse(state.queryParameters['idOrder'].toString());

    return pages
      ..add(
        BeamPage(
          key: ValueKey('order-detail-$idOrder'),
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
