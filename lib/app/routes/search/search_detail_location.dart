import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/search_detail/search_detail_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/search_detail/search_detail_view_factory.dart';
import 'package:ecommerce/app/routes/search/search_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchDetailLocation extends BeamLocation<BeamState> {
  SearchDetailLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final keyword = state.queryParameters['keyword'] ?? '';

    final pages = [
      BeamPage(
        key: ValueKey('search-detail-$keyword'),
        child: ChangeNotifierProvider(
          create: (_) => makeSearchDetailPresenter(),
          child: makeSearchDetailView(keyword: keyword),
        ),
      ),
    ];

    return SearchLocation().buildPages(context, state)..addAll(pages);
  }

  @override
  List<Pattern> get pathPatterns => ['search/result?keyword:keyword'];
}
