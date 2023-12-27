import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:flutter/material.dart';

abstract class CheckOutPresenter implements ChangeNotifier {
  void initData();
  void setShippingMethod({required String method});
  void setNewAddress({required AddressEntity newAddress});
  void checkOut();

  String get shippingMethod;
  bool get isLoading;
  AddressEntity? get selectedAddress;
  double get shippingFee;
  double get vatFee;
  double get totalBeforeVAT;
  double get total;
  List<AddressEntity> get addresses;
  String? get navigateTo;
}
