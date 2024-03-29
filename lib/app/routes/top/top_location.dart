import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/top/top_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/top/top_view_factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopLocation extends BeamLocation<BeamState> {
  TopLocation([super.routeInformation]);
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('top'),
        title: 'Top',
        child: ChangeNotifierProvider(
          create: (_) => makeTopPresenter(),
          child: makeTopView(),
        ),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/top*'];
}
