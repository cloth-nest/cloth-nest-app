import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:flutter/material.dart';

abstract class CheckOutPresenter implements ChangeNotifier {
  void initData(int? variantId);
  void setShippingMethod({required String method});
  void setPaymentMethod({required String method});
  void setNewAddress({required AddressEntity newAddress});
  void checkOut();

  List<String> get shippingMethods;
  String get shippingMethod;
  String get paymentMethod;
  bool get isLoading;
  AddressEntity? get selectedAddress;
  double get shippingFee;
  double get vatFee;
  double get totalBeforeVAT;
  double get total;
  List<AddressEntity> get addresses;
  String? get navigateTo;
}
