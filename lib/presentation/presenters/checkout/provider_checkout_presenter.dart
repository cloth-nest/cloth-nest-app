import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/entities/bill/bill_entity.dart';
import 'package:ecommerce/domain/usecases/bill/fetch_calculate_bill.dart';
import 'package:ecommerce/domain/usecases/detail_address/fetch_detail_address.dart';
import 'package:ecommerce/domain/usecases/fetch_address/fetch_address.dart';
import 'package:ecommerce/presentation/presenters/checkout/checkout_out_state.dart';
import 'package:ecommerce/presentation/screens/checkout/checkout_presenter.dart';
import 'package:flutter/material.dart';

class ProviderCheckOutPresenter
    with ChangeNotifier
    implements CheckOutPresenter {
  CheckOutState _state;
  final FetchDetailAddress _fetchDetailAddress;
  final FetchCalculateBill _fetchCalculateBill;
  final FetchAddress _fetchAddress;

  ProviderCheckOutPresenter({
    required CheckOutState state,
    required FetchDetailAddress fetchDetailAddress,
    required FetchCalculateBill fetchCalculateBill,
    required FetchAddress fetchAddress,
  })  : _state = state,
        _fetchDetailAddress = fetchDetailAddress,
        _fetchCalculateBill = fetchCalculateBill,
        _fetchAddress = fetchAddress;

  Future _calculateFee() async {
    try {
      BillEntity bill = await _fetchCalculateBill.call(
        ghnServerTypeId: getServiceId(),
        addressId: _state.selectedAddress?.id ?? 1,
      );

      _state = _state.copyWith(
        billEntity: bill,
      );
    } catch (e) {
      debugPrint('###error calculate fee: $e');
    }
  }

  @override
  void initData() async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();
      // for testing
      AddressEntity address = await _fetchDetailAddress.call(id: 3);
      BillEntity bill = await _fetchCalculateBill.call(
        ghnServerTypeId: getServiceId(),
        addressId: address.id,
      );
      List<AddressEntity> addresses = await _fetchAddress.call();

      _state = _state.copyWith(
        selectedAddress: address,
        isLoading: false,
        billEntity: bill,
        addresses: addresses,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('###error init data checkout: $e');
    }
  }

  @override
  bool get isLoading => _state.isLoading;

  @override
  AddressEntity? get selectedAddress => _state.selectedAddress;

  @override
  double get shippingFee => _state.billEntity?.shippingFee ?? 0;

  @override
  double get total => _state.billEntity?.total ?? 0;

  @override
  double get totalBeforeVAT => _state.billEntity?.totalBeforeVAT ?? 0;

  @override
  double get vatFee => _state.billEntity?.vatFee ?? 0;

  @override
  void setShippingMethod({required String method}) async {
    if (_state.shippingMethod != method) {
      _state = _state.copyWith(shippingMethod: method);
      await _calculateFee();
      notifyListeners();
    }
  }

  @override
  String get shippingMethod => _state.shippingMethod;

  int getServiceId() {
    switch (shippingMethod) {
      case 'Normal Delivery':
        return 2;
      default:
        return 5;
    }
  }

  @override
  List<AddressEntity> get addresses => _state.addresses;

  @override
  void setNewAddress({required AddressEntity newAddress}) async {
    try {
      if (_state.selectedAddress != newAddress) {
        _state = _state.copyWith(
          isLoading: true,
          selectedAddress: newAddress,
        );
        notifyListeners();

        await _calculateFee();
        _state = _state.copyWith(isLoading: false);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('###error set new address: $e');
    }
  }
}
