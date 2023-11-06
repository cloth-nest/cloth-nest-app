import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/presentation/presenters/address/address_state.dart';
import 'package:ecommerce/presentation/screens/address/address_presenter.dart';
import 'package:ecommerce/presentation/screens/address/widget/item_type_address.dart';
import 'package:ecommerce/presentation/screens/address/widget/vertical_list_addresses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late AddressPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<AddressPresenter>();
    _presenter.addListener(_onListener);
    _presenter.initData();
  }

  void _onListener() {
    if (_presenter.navigateTo != null) {
      switch (_presenter.navigateTo) {
        case AddressDirection.add:
          final String currentLocation =
              context.currentBeamLocation.state.routeInformation.location ??
                  '/';
          final uri = Uri.parse(currentLocation);
          context.beamToNamed('${uri.path}/add');
          break;
        case AddressDirection.detail:
          final String currentLocation =
              context.currentBeamLocation.state.routeInformation.location ??
                  '/';
          final uri = Uri.parse(currentLocation);
          context.beamToNamed(
              '${uri.path}/detail?idAddress=${_presenter.selectedAddress?.id}');
          break;
        default:
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.removeListener(_onListener);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            icon: SvgPicture.asset(
              SvgPaths.iconArrowLeft,
            ),
            onPressed: () {
              if (context.canPopBeamLocation) {
                context.popBeamLocation();
              }
            },
          ),
        ),
        elevation: 0.3,
        title: Text(
          'Saved Address',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: size.height,
            child: Column(
              children: [
                ItemTypeAddress(
                  typeAddress: 'Add home address',
                  leading: const Icon(Icons.home),
                  onTap: () {},
                ),
                ItemTypeAddress(
                  typeAddress: 'Add company address',
                  leading: const Icon(Icons.business),
                  onTap: () {},
                ),
                ItemTypeAddress(
                  typeAddress: 'Add new address',
                  leading: const Icon(Icons.add),
                  onTap: () {
                    _presenter.navigateToAddAddressScreen();
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Selector<AddressPresenter, List<AddressEntity>>(
                    selector: (_, presenter) => presenter.addresses,
                    builder: (_, addresses, __) {
                      return VerticalListAddresses(
                        addresses: addresses,
                        callback: (address) {
                          _presenter.navigateToDetailAddressScreen(
                              address: address);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
