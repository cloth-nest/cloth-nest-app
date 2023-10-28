import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/reset_password/reset_password_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/reset_password/reset_password_view_factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final email = state.queryParameters['email'] ?? '';
    return [
      BeamPage(
        key: const ValueKey('reset_password'),
        child: ChangeNotifierProvider(
          create: (_) => makeResetPasswordPresenter(),
          child: makeResetPasswordView(
            email: email,
          ),
        ),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/reset_password?email=:email'];
}
