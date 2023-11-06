import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/detail_address/detail_address_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/detail_address/detail_address_view_factory.dart';
import 'package:ecommerce/app/routes/account/account_address_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountDetailAddressLocation extends BeamLocation<BeamState> {
  AccountDetailAddressLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final accountAddressLocation = AccountAddressLocation();
    final pages = accountAddressLocation.buildPages(context, state);
    final idAddress = int.parse(state.queryParameters['idAddress'] ?? '0');

    return pages
      ..add(
        BeamPage(
          key: ValueKey('detail-address-$idAddress'),
          child: ChangeNotifierProvider(
            create: (_) => makeDetailAddressPresenter(),
            child: makeDetailAddressView(
              idAddress: idAddress,
            ),
          ),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/detail?idAddress=:int'];
}
