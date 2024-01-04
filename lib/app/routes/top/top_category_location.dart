import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/detail_category/detail_category_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/detail_category/detail_category_view_factory.dart';
import 'package:ecommerce/app/routes/top/top_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopCategoryLocation extends BeamLocation<BeamState> {
  TopCategoryLocation([super.routeInformation]);
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final topLocation = TopLocation();
    final pages = topLocation.buildPages(context, state);
    final title = state.queryParameters['title'] ?? '';
    final int id = int.parse(state.queryParameters['id'] ?? '-1');

    return pages
      ..add(
        BeamPage(
          key: const ValueKey('detail-category'),
          child: ChangeNotifierProvider.value(
            value: makeDetailCategoryPresenter(),
            child: makeDetailCategoryView(
              title: title,
              id: id,
            ),
          ),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/detail?title=:String&id=:id'];
}
