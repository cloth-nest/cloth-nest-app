import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/presentation/presenters/address/address_state.dart';
import 'package:flutter/material.dart';

abstract class AddressPresenter implements ChangeNotifier {
  void navigateToAddAddressScreen();
  void initData();
  void navigateToDetailAddressScreen({required AddressEntity address});

  AddressDirection? get navigateTo;
  List<AddressEntity> get addresses;
  AddressEntity? get selectedAddress;
}
