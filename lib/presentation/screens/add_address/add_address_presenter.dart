import 'package:ecommerce/domain/entities/place/place_entity.dart';
import 'package:flutter/material.dart';

abstract class AddAddressPresenter implements ChangeNotifier {
  void navigateToAddAddress();
  void initData();
  void setProvince({required PlaceEntity newProvince});
  void setDistrict({required PlaceEntity newDistrict});
  void setWard({required PlaceEntity newWard});
  void setEmail({required String newEmail});
  void setFirstName({required String firstName});
  void setLastName({required String lastName});
  void setPhone({required String phone});
  void setDetailAddress({required String detail});
  void createAddress();

  bool get isLoading;
  bool get isFormValid;
  PlaceEntity? get selectedProvince;
  PlaceEntity? get selectedDistrict;
  PlaceEntity? get selectedWard;
  List<PlaceEntity> get provinces;
  List<PlaceEntity> get districts;
  List<PlaceEntity> get wards;
  String? get navigateTo;
}
