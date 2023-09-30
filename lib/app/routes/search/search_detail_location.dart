import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/routes/search/search_location.dart';
import 'package:ecommerce/presentation/screens/search_detail.dart/search_detail_screen.dart';
import 'package:flutter/material.dart';

class SearchDetailLocation extends BeamLocation<BeamState> {
  SearchDetailLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final keyword = state.queryParameters['keyword'] ?? '';

    final pages = [
      BeamPage(
        key: ValueKey('search-detail-$keyword'),
        child: SearchDetailScreen(keyword: keyword),
      ),
    ];

    return SearchLocation().buildPages(context, state)..addAll(pages);
  }

  @override
  List<Pattern> get pathPatterns => ['search/result?keyword:keyword'];
}
