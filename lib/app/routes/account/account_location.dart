import 'package:beamer/beamer.dart';
import 'package:ecommerce/presentation/screens/account/account_screen.dart';
import 'package:flutter/material.dart';

class AccountLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('account'),
        title: 'account',
        child: AccountView(),
      )
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/*'];
}
