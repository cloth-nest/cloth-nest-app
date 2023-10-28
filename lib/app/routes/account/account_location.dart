import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/account/account_view_factory.dart';
import 'package:flutter/material.dart';

class AccountLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('account'),
        title: 'account',
        child: makeAccountView(),
      )
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/*'];
}
