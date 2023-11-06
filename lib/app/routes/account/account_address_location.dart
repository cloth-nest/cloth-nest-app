import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/address/address_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/address/address_view_factory.dart';
import 'package:ecommerce/app/routes/account/account_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountAddressLocation extends BeamLocation<BeamState> {
  AccountAddressLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final accountLocation = AccountLocation();
    final pages = accountLocation.buildPages(context, state);

    return pages
      ..add(
        BeamPage(
          key: const ValueKey('account-address'),
          child: ChangeNotifierProvider(
            create: (_) => makeAddressPresenter(),
            child: makeAddressView(),
          ),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/address'];
}
