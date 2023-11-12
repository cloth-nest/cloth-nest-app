import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/add_address/add_address_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/add_address/add_address_view_factory.dart';
import 'package:ecommerce/app/routes/account/account_address_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountAddAddressLocation extends BeamLocation<BeamState> {
  AccountAddAddressLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final accountAddressLocation = AccountAddressLocation();
    final pages = accountAddressLocation.buildPages(context, state);

    return pages
      ..add(
        BeamPage(
          key: const ValueKey('account-address-add'),
          child: ChangeNotifierProvider(
            create: (_) => makeAddAddressPresenter(),
            child: makeAddAdressView(),
          ),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/add'];
}
