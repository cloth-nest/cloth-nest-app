import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/order/order_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/order/order_view_factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderLocation extends BeamLocation<BeamState> {
  OrderLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('order'),
        title: 'order',
        child: ChangeNotifierProvider(
          create: (_) => makeOrderPresenter(),
          child: makeOrderView(
            isCanBack: false,
          ),
        ),
      )
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/order*'];
}
