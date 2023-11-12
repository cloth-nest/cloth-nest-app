import 'package:ecommerce/data/http/exceptions/http_exception.dart';
import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/usecases/delete_address/fetch_delete_address.dart';
import 'package:ecommerce/domain/usecases/fetch_address/fetch_address.dart';
import 'package:ecommerce/presentation/presenters/address/address_state.dart';
import 'package:ecommerce/presentation/screens/address/address_presenter.dart';
import 'package:flutter/material.dart';

class ProviderAddressPresenter with ChangeNotifier implements AddressPresenter {
  AddressState _state;

  final FetchAddress _fetchAddress;
  final FetchDeleteAddress _fetchDeleteAddress;

  ProviderAddressPresenter({
    required AddressState state,
    required FetchAddress fetchAddress,
    required FetchDeleteAddress fetchDeleteAddress,
  })  : _state = state,
        _fetchAddress = fetchAddress,
        _fetchDeleteAddress = fetchDeleteAddress;

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

  @override
  void deleteAddress({required int idAddress}) async {
    try {
      await _fetchDeleteAddress.call(id: idAddress);
      List<AddressEntity> tmp = [...addresses];
      tmp.removeWhere((element) => element.id == idAddress);
      _state = _state.copyWith(addresses: tmp);
      notifyListeners();
    } on HttpException catch (e) {
      switch (e.code) {
        case 'A0002':
          _state =
              _state.copyWith(errorMessage: 'Can\'t delete default address');
          notifyListeners();
          break;
        default:
      }
    } catch (e) {
      debugPrint('error delete address: $e');
    }
  }

  @override
  bool get isDefault => true;

  @override
  String? get errorMessage => _state.errorMessage;

  @override
  void addAddress({required AddressEntity addressEntity}) {
    _state = _state.copyWith(addresses: [...addresses, addressEntity]);
    notifyListeners();
  }

  @override
  void editAddress({required AddressEntity addressEntity}) {
    List<AddressEntity> tmp = [...addresses];

    for (var entity in tmp) {
      if (entity.id == addressEntity.id) {
        tmp.remove(entity);
        break;
      }
    }

    _state = _state.copyWith(addresses: [...tmp, addressEntity]);
    notifyListeners();
  }
}
