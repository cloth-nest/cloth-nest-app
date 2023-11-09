import 'package:ecommerce/domain/entities/place/place_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class DetailAddressPresenter implements ChangeNotifier {
  bool get isLoading;
  TextEditingController get firstNameController;
  TextEditingController get lastNameController;
  TextEditingController get emailController;
  TextEditingController get phoneController;
  TextEditingController get detailController;
  PlaceEntity? get selectedProvince;
  PlaceEntity? get selectedWard;
  PlaceEntity? get selectedDistrict;
  bool get isFormValid;
  List<PlaceEntity> get provinces;
  List<PlaceEntity> get districts;
  List<PlaceEntity> get wards;
  String? get navigateTo;
  bool get isDefault;

  void initData({required int idAddress});
  void setProvince({required PlaceEntity newProvince});
  void setDistrict({required PlaceEntity newDistrict});
  void setWard({required PlaceEntity newWard});
  void setEmail({required String newEmail});
  void setFirstName({required String firstName});
  void setLastName({required String lastName});
  void setPhone({required String phone});
  void setDetailAddress({required String detail});
  void editAddress();
  void setDefaultAddress({required bool isDefault});
}
