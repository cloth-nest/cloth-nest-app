import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/search/search_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/search/search_view_factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchLocation extends BeamLocation<BeamState> {
  SearchLocation([super.routeInformation]);
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('search'),
        title: 'Search',
        child: ChangeNotifierProvider(
          create: (_) => makeSearchPresenter(),
          child: makeSearchView(),
        ),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/search*'];
}
