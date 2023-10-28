import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/splash/splash_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/splash/splash_view_factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('splash'),
        title: 'Splash',
        child: ChangeNotifierProvider(
          create: (_) => makeSplashPresenter(),
          child: makeSplashView(),
        ),
      )
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/splash'];
}
