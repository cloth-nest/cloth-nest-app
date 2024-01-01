import 'package:ecommerce/app/factories/usecases/firebase_token/firebase_token_factory.dart';
import 'package:ecommerce/app/factories/usecases/send_notification/send_notification_factory.dart';
import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/entities/bill/bill_entity.dart';
import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:ecommerce/domain/entities/payment/payment_result_entity.dart';
import 'package:ecommerce/domain/entities/service_type/service_type_entity.dart';
import 'package:ecommerce/domain/usecases/bill/fetch_calculate_bill.dart';
import 'package:ecommerce/domain/usecases/fetch_address/fetch_address.dart';
import 'package:ecommerce/domain/usecases/checkout/fetch_checkout.dart';
import 'package:ecommerce/domain/usecases/payment/fetch_payment.dart';
import 'package:ecommerce/domain/usecases/service_type/fetch_service_type.dart';
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
  final FetchServiceType _fetchServiceType;

  ProviderCheckOutPresenter({
    required CheckOutState state,
    required FetchCalculateBill fetchCalculateBill,
    required FetchAddress fetchAddress,
    required FetchCheckOut fetchOrder,
    required FetchPayment fetchPayment,
    required FetchServiceType fetchServiceType,
  })  : _state = state,
        _fetchCalculateBill = fetchCalculateBill,
        _fetchAddress = fetchAddress,
        _fetchCheckOut = fetchOrder,
        _fetchPayment = fetchPayment,
        _fetchServiceType = fetchServiceType;

  Future _calculateFee() async {
    try {
      late BillEntity bill;

      if (idVariant == null) {
        bill = await _fetchCalculateBill.call(
          ghnServerTypeId: getServiceId(),
          addressId: _state.selectedAddress?.id ?? 1,
        );
      } else {
        bill = await _fetchCalculateBill.call(
          ghnServerTypeId: getServiceId(),
          addressId: _state.selectedAddress?.id ?? 1,
          carts: {
            'productVariantId': idVariant,
            'quantity': 1,
          },
        );
      }

      _state = _state.copyWith(
        billEntity: bill,
      );
    } catch (e) {
      debugPrint('###error calculate fee: $e');
    }
  }

  int? idVariant;

  Future _getShippingMethods() async {
    List<ServiceTypeEntity> services = await _fetchServiceType.call(
      toDistrict: _state.selectedAddress!.districtCode,
    );

    List<String> shippingMethods = services.map((e) => e.shortName).toList();

    _state = _state.copyWith(
      shippingMethods: shippingMethods,
    );
  }

  @override
  void initData(int? variantId) async {
    try {
      idVariant = variantId;

      _state = _state.copyWith(isLoading: true);
      notifyListeners();
      late AddressEntity defaultAddress;

      List<AddressEntity> addresses = await _fetchAddress.call();

      for (final address in addresses) {
        if (address.isDefault == true) {
          defaultAddress = address;
        }
      }

      _state = _state.copyWith(
        selectedAddress: defaultAddress,
      );
      await _getShippingMethods();
      await _calculateFee();

      _state = _state.copyWith(
        selectedAddress: defaultAddress,
        isLoading: false,
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
        await _getShippingMethods();

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
      late OrderEntity orderEntity;

      if (idVariant == null) {
        orderEntity = await _fetchCheckOut.checkOutFromCart(
          addressId: _state.selectedAddress?.id ?? -1,
          phone: _state.selectedAddress?.phone ?? '',
          ghnServerTypeId: getServiceId(),
          paymentMethod: _isPaymentByZaloPay() ? 'ZALO_PAY' : 'CASH',
        );
      } else {
        orderEntity = await _fetchCheckOut.checkOutNow(
          addressId: _state.selectedAddress?.id ?? -1,
          phone: _state.selectedAddress?.phone ?? '',
          ghnServerTypeId: getServiceId(),
          paymentMethod: _isPaymentByZaloPay() ? 'ZALO_PAY' : 'CASH',
          variantId: idVariant!,
          quantity: 1,
        );
      }

      final String adminToken =
          await makeFetchFirebaseToken().call(email: 'root@clothnest.vn');

      await makeFetchSendNotification().call(
        name:
            '${_state.selectedAddress?.firstName} ${_state.selectedAddress?.lastName} has created an order',
        token: adminToken,
      );

      if (_isPaymentByZaloPay()) {
        PaymentResultEntity paymentResultEntity =
            await _fetchPayment.call(orderId: orderEntity.id);

        await const MethodChannel('flutter.native/channelPayOrder')
            .invokeMethod('payOrder', {
          "zptoken": paymentResultEntity.zpTransToken,
        });
      } else {
        _state = _state.copyWith(navigateTo: 'success');
        notifyListeners();
      }
    } catch (e) {
      debugPrint('##error check out: $e');
    }
  }

  bool _isPaymentByZaloPay() {
    return paymentMethod.contains('Zalo');
  }

  @override
  String? get navigateTo => _state.navigateTo;

  @override
  String get paymentMethod => _state.paymentMethod;

  @override
  void setPaymentMethod({required String method}) {
    if (_state.paymentMethod != method) {
      _state = _state.copyWith(paymentMethod: method);
      notifyListeners();
    }
  }

  @override
  List<String> get shippingMethods => _state.shippingMethods;
}
