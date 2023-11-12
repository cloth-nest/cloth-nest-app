import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/address/address_view_factory.dart';
import 'package:ecommerce/app/routes/account/account_location.dart';
import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:flutter/material.dart';

class AccountAddressLocation extends BeamLocation<BeamState> {
  AccountAddressLocation([super.routeInformation]);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final accountLocation = AccountLocation();
    final pages = accountLocation.buildPages(context, state);

    AddressEntity? newAddress;

    if (data != null) {
      newAddress = data as AddressEntity;
    }

    return pages
      ..add(
        BeamPage(
          key: const ValueKey('account-address'),
          child: makeAddressView(newAddress: newAddress),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/address'];
}
