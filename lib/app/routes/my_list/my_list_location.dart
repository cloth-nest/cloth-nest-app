import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/my_list/my_list_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/my_list/my_list_view_factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyListLocation extends BeamLocation<BeamState> {
  MyListLocation([super.routeInformation]);
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('my_list'),
        child: ChangeNotifierProvider(
          create: (_) => makeMyListPresenter(),
          child: makeMyListView(),
        ),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/my_list*'];
}
