import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/profile/profile_view_factory.dart';
import 'package:ecommerce/app/factories/presentation/profile/profile_view_presenter_factory.dart';
import 'package:ecommerce/app/routes/account/account_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountProfileLocation extends BeamLocation<BeamState> {
  AccountProfileLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final accountLocation = AccountLocation();
    final pages = accountLocation.buildPages(context, state);
    pages.add(
      BeamPage(
        key: const ValueKey('profile'),
        child: ChangeNotifierProvider(
          create: (_) => makeProfilePresenter(),
          child: makeProfileView(),
        ),
      ),
    );
    return pages;
  }

  @override
  List<Pattern> get pathPatterns => ['/profile'];
}
