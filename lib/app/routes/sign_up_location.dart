import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/sign_up/sign_up_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/sign_up/sign_up_view_factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('sign_up'),
        title: 'signup',
        child: ChangeNotifierProvider(
          create: (_) => makeSignUpPresenter(),
          child: makeSignUpView(),
        ),
      )
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/sign_up'];
}
