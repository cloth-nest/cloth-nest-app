import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/product_detail/product_detail_view_factory.dart';
import 'package:ecommerce/app/routes/my_list/my_list_location.dart';
import 'package:flutter/material.dart';

class MyListProductLocation extends BeamLocation<BeamState> {
  MyListProductLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final myListLocation = MyListLocation();
    final pages = myListLocation.buildPages(context, state);

    return pages
      ..add(
        BeamPage(
          key: const ValueKey('my-list-product'),
          child: makeProductDetailView(idProduct: 1),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/product'];
}
