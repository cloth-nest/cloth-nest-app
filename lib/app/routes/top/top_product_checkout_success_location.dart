import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/check_out/check_out_view_factory.dart';
import 'package:ecommerce/app/routes/top/top_product_checkout_location.dart';
import 'package:flutter/material.dart';

class TopProductCheckOutSuccessLocation extends BeamLocation<BeamState> {
  TopProductCheckOutSuccessLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final cartCheckOutLocation = TopProductCheckOutLocation();
    final pages = cartCheckOutLocation.buildPages(context, state);

    return pages
      ..add(
        BeamPage(
          key: const ValueKey('check-out-success'),
          child: makeSuccessCheckOutView(),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/success'];
}
