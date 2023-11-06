import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/usecases/fetch_address/fetch_address.dart';
import 'package:ecommerce/presentation/presenters/address/address_state.dart';
import 'package:ecommerce/presentation/screens/address/address_presenter.dart';
import 'package:flutter/material.dart';

class ProviderAddressPresenter with ChangeNotifier implements AddressPresenter {
  AddressState _state;

  final FetchAddress _fetchAddress;

  ProviderAddressPresenter({
    required AddressState state,
    required FetchAddress fetchAddress,
  })  : _state = state,
        _fetchAddress = fetchAddress;

  @override
  void navigateToAddAddressScreen() {
    _state = _state.copyWith(navigateTo: AddressDirection.add);
    notifyListeners();
  }

  @override
  AddressDirection? get navigateTo => _state.navigateTo;

  @override
  void initData() async {
    try {
      List<AddressEntity> addresses = await _fetchAddress.call();
      _state = _state.copyWith(addresses: addresses);
      notifyListeners();
    } catch (e) {
      debugPrint('error init data address: $e');
    }
  }

  @override
  List<AddressEntity> get addresses => _state.addresses;

  @override
  void navigateToDetailAddressScreen({required AddressEntity address}) {
    _state = _state.copyWith(
      navigateTo: AddressDirection.detail,
      selectedAddress: address,
    );
    notifyListeners();
  }

  @override
  AddressEntity? get selectedAddress => _state.selectedAddress;
}
