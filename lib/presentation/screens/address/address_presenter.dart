import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/presentation/presenters/address/address_state.dart';
import 'package:flutter/material.dart';

abstract class AddressPresenter implements ChangeNotifier {
  void navigateToAddAddressScreen();
  void initData();
  void navigateToDetailAddressScreen({required AddressEntity address});
  void deleteAddress({required int idAddress});
  void addAddress({required AddressEntity addressEntity});
  void editAddress({required AddressEntity addressEntity});

  AddressDirection? get navigateTo;
  List<AddressEntity> get addresses;
  AddressEntity? get selectedAddress;
  bool get isDefault;
  String? get errorMessage;
}
