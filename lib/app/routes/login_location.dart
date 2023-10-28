import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/login/login_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/login/login_view_factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('login'),
        title: 'login',
        child: ChangeNotifierProvider(
          create: (_) => makeLoginPresenter(),
          child: makeLoginView(),
        ),
      )
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/login'];
}
