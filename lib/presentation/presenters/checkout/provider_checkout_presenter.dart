import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/entities/bill/bill_entity.dart';
import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:ecommerce/domain/entities/payment/payment_result_entity.dart';
import 'package:ecommerce/domain/usecases/bill/fetch_calculate_bill.dart';
import 'package:ecommerce/domain/usecases/fetch_address/fetch_address.dart';
import 'package:ecommerce/domain/usecases/checkout/fetch_checkout.dart';
import 'package:ecommerce/domain/usecases/payment/fetch_payment.dart';
import 'package:ecommerce/presentation/presenters/checkout/checkout_out_state.dart';
import 'package:ecommerce/presentation/screens/checkout/checkout_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProviderCheckOutPresenter
    with ChangeNotifier
    implements CheckOutPresenter {
  CheckOutState _state;
  final FetchCalculateBill _fetchCalculateBill;
  final FetchAddress _fetchAddress;
  final FetchCheckOut _fetchCheckOut;
  final FetchPayment _fetchPayment;

  ProviderCheckOutPresenter({
    required CheckOutState state,
    required FetchCalculateBill fetchCalculateBill,
    required FetchAddress fetchAddress,
    required FetchCheckOut fetchOrder,
    required FetchPayment fetchPayment,
  })  : _state = state,
        _fetchCalculateBill = fetchCalculateBill,
        _fetchAddress = fetchAddress,
        _fetchCheckOut = fetchOrder,
        _fetchPayment = fetchPayment;

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
      late AddressEntity defaultAddress;

      List<AddressEntity> addresses = await _fetchAddress.call();

      for (final address in addresses) {
        if (address.isDefault == true) {
          defaultAddress = address;
        }
      }

      BillEntity bill = await _fetchCalculateBill.call(
        ghnServerTypeId: getServiceId(),
        addressId: defaultAddress.id,
      );

      _state = _state.copyWith(
        selectedAddress: defaultAddress,
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

  @override
  void checkOut() async {
    try {
      OrderEntity orderEntity = await _fetchCheckOut.call(
        addressId: _state.selectedAddress?.id ?? -1,
        phone: _state.selectedAddress?.phone ?? '',
        ghnServerTypeId: 2,
        paymentMethod: 'ZALO_PAY',
      );
      PaymentResultEntity paymentResultEntity =
          await _fetchPayment.call(orderId: orderEntity.id);

      await const MethodChannel('flutter.native/channelPayOrder')
          .invokeMethod('payOrder', {
        "zptoken": paymentResultEntity.zpTransToken,
      });

      debugPrint('##go to here');
    } catch (e) {
      debugPrint('##error check out: $e');
    }
  }

  @override
  String? get navigateTo => _state.navigateTo;
}
