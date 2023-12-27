import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/entities/place/place_entity.dart';
import 'package:ecommerce/domain/usecases/default_address/fetch_default_address.dart';
import 'package:ecommerce/domain/usecases/detail_address/fetch_detail_address.dart';
import 'package:ecommerce/domain/usecases/edit_address/edit_address_params.dart';
import 'package:ecommerce/domain/usecases/edit_address/fetch_edit_address.dart';
import 'package:ecommerce/domain/usecases/place/fetch_districts.dart';
import 'package:ecommerce/domain/usecases/place/fetch_provinces.dart';
import 'package:ecommerce/domain/usecases/place/fetch_wards.dart';
import 'package:ecommerce/presentation/presenters/detail_address/detail_address_state.dart';
import 'package:ecommerce/presentation/screens/detail_address/detail_address_presenter.dart';
import 'package:flutter/material.dart';

class ProviderDetailAddressPresenter
    with ChangeNotifier
    implements DetailAddressPresenter {
  DetailAddressState _state;

  final FetchDetailAddress _fetchDetailAddress;
  final FetchDistricts _fetchDistricts;
  final FetchWards _fetchWards;
  final FetchProvinces _fetchProvinces;
  final FetchEditAddress _fetchEditAddress;
  final FetchDefaultAddress _fetchDefaultAddress;

  ProviderDetailAddressPresenter({
    required DetailAddressState state,
    required FetchDetailAddress fetchDetailAddress,
    required FetchDistricts fetchDistricts,
    required FetchWards fetchWards,
    required FetchProvinces fetchProvinces,
    required FetchEditAddress fetchEditAddress,
    required FetchDefaultAddress fetchDefaultAddress,
  })  : _state = state,
        _fetchDetailAddress = fetchDetailAddress,
        _fetchDistricts = fetchDistricts,
        _fetchProvinces = fetchProvinces,
        _fetchWards = fetchWards,
        _fetchEditAddress = fetchEditAddress,
        _fetchDefaultAddress = fetchDefaultAddress;

  @override
  bool get isLoading => _state.isLoading;

  PlaceEntity? districtTmp, provinceTmp, wardTmp;

  @override
  void initData({required int idAddress}) async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      AddressEntity entity = await _fetchDetailAddress.call(id: idAddress);

      List<PlaceEntity> provinces = await _getProvinces();
      List<PlaceEntity> wards = await _getWards(entity.districtCode);
      List<PlaceEntity> districts = await _getDistricts(entity.provinceCode);

      for (var district in districts) {
        if (district.code == entity.districtCode &&
            district.name == entity.districtName) {
          districtTmp = district;
        }
      }

      for (var ward in wards) {
        if (ward.code.toString() == entity.wardCode &&
            ward.name == entity.wardName) {
          wardTmp = ward;
        }
      }

      for (var province in provinces) {
        if (province.code == entity.provinceCode &&
            province.name == entity.provinceName) {
          provinceTmp = province;
        }
      }
      _state = _state.copyWith(
        id: idAddress,
        selectedDistrict: districtTmp,
        selectedProvince: provinceTmp,
        selectedWard: wardTmp,
        address: entity,
        isLoading: false,
        provinces: provinces,
        wards: wards,
        districts: districts,
        email: entity.email,
        phone: entity.phone,
        firstName: entity.firstName,
        lastName: entity.lastName,
        detailAddress: entity.detail,
        firstNameController: TextEditingController(text: entity.firstName),
        lastNameController: TextEditingController(text: entity.lastName),
        phoneController: TextEditingController(text: entity.phone),
        mailController: TextEditingController(text: entity.email),
        detailController: TextEditingController(text: entity.detail),
        isDefault: entity.isDefault,
      );

      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
      );
      notifyListeners();
      debugPrint('error init data: $e');
    }
  }

  @override
  TextEditingController get detailController => _state.detailController;

  @override
  TextEditingController get emailController => _state.mailController;

  @override
  TextEditingController get firstNameController => _state.firstNameController;

  @override
  TextEditingController get lastNameController => _state.lastNameController;

  @override
  TextEditingController get phoneController => _state.phoneController;

  @override
  PlaceEntity? get selectedDistrict => _state.selectedDistrict;

  @override
  PlaceEntity? get selectedProvince => _state.selectedProvince;

  @override
  PlaceEntity? get selectedWard => _state.selectedWard;

  @override
  void setProvince({required PlaceEntity newProvince}) async {
    if (_state.selectedProvince != newProvince) {
      provinceTmp = newProvince;
      districtTmp = null;
      wardTmp = null;

      List<PlaceEntity> districts = await _getDistricts(newProvince.code);

      _state = _state.copyWith(
        selectedProvince: newProvince,
        districts: districts,
        selectedWard: null,
        selectedDistrict: null,
      );

      _validateForm();
      notifyListeners();
    }
  }

  Future<List<PlaceEntity>> _getProvinces() async {
    try {
      List<PlaceEntity> provinces = await _fetchProvinces.call();
      return provinces;
    } catch (e) {
      debugPrint('error init data add address: $e');
    }
    return [];
  }

  Future<List<PlaceEntity>> _getDistricts(int code) async {
    try {
      List<PlaceEntity> districs = await _fetchDistricts.call(code: code);
      return districs;
    } catch (e) {
      debugPrint('error get districts: $e');
    }
    return [];
  }

  Future<List<PlaceEntity>> _getWards(int code) async {
    try {
      List<PlaceEntity> wards = await _fetchWards.call(code: code);
      return wards;
    } catch (e) {
      debugPrint('error get wards: $e');
    }
    return [];
  }

  @override
  void setDistrict({required PlaceEntity newDistrict}) async {
    if (_state.selectedDistrict != newDistrict) {
      districtTmp = newDistrict;
      wardTmp = null;

      List<PlaceEntity> wards = await _getWards(newDistrict.code);

      _state = _state.copyWith(
        selectedDistrict: newDistrict,
        wards: wards,
        selectedWard: null,
      );

      _validateForm();
      notifyListeners();
    }
  }

  @override
  void setWard({required PlaceEntity newWard}) {
    if (_state.selectedWard != newWard) {
      wardTmp = newWard;

      _state = _state.copyWith(
        selectedWard: newWard,
      );
      _validateForm();

      notifyListeners();
    }
  }

  @override
  void setEmail({required String newEmail}) {
    if (_state.email != newEmail) {
      _state = _state.copyWith(
        email: newEmail,
        selectedProvince: provinceTmp,
        selectedDistrict: districtTmp,
        selectedWard: wardTmp,
      );
      _validateForm();

      notifyListeners();
    }
  }

  @override
  void setFirstName({required String firstName}) {
    if (_state.firstName != firstName) {
      _state = _state.copyWith(
        firstName: firstName,
        selectedProvince: provinceTmp,
        selectedDistrict: districtTmp,
        selectedWard: wardTmp,
      );
      _validateForm();

      notifyListeners();
    }
  }

  @override
  void setLastName({required String lastName}) {
    if (_state.lastName != lastName) {
      _state = _state.copyWith(
        lastName: lastName,
        selectedProvince: provinceTmp,
        selectedDistrict: districtTmp,
        selectedWard: wardTmp,
      );
      _validateForm();

      notifyListeners();
    }
  }

  @override
  void setPhone({required String phone}) {
    if (_state.phone != phone) {
      _state = _state.copyWith(
        phone: phone,
        selectedProvince: provinceTmp,
        selectedDistrict: districtTmp,
        selectedWard: wardTmp,
      );
      _validateForm();

      notifyListeners();
    }
  }

  void _validateForm() {
    _state = _state.copyWith(
      isFormValid: _state.email != null &&
          _state.email!.isNotEmpty &&
          _state.firstName != null &&
          _state.firstName!.isNotEmpty &&
          _state.lastName != null &&
          _state.lastName!.isNotEmpty &&
          _state.phone != null &&
          _state.phone!.isNotEmpty &&
          _state.detailAddress != null &&
          _state.detailAddress!.isNotEmpty &&
          provinceTmp != null &&
          districtTmp != null &&
          wardTmp != null,
      selectedProvince: provinceTmp,
      selectedDistrict: districtTmp,
      selectedWard: wardTmp,
    );
  }

  @override
  void setDetailAddress({required String detail}) {
    if (_state.detailAddress != detail) {
      _state = _state.copyWith(
        detailAddress: detail,
        selectedProvince: provinceTmp,
        selectedDistrict: districtTmp,
        selectedWard: wardTmp,
      );
      _validateForm();

      notifyListeners();
    }
  }

  @override
  void editAddress() async {
    try {
      _state = _state.copyWith(
        isLoading: true,
      );
      notifyListeners();

      AddressEntity entity = await _fetchEditAddress.call(
        params: EditAddressParams(
          email: _state.email!,
          firstName: _state.firstName!,
          lastName: _state.lastName!,
          provinceCode: provinceTmp!.code,
          provinceName: provinceTmp!.name,
          districtCode: districtTmp!.code,
          districtName: districtTmp!.name,
          wardCode: wardTmp!.code,
          wardName: wardTmp!.name,
          detail: _state.detailAddress!,
          phone: _state.phone!,
          id: _state.id!,
        ),
      );
      if (_state.isDefault) {
        await _fetchDefaultAddress.call(id: _state.id!);
        entity = entity.copyWith(isDefault: true);
      }

      _state = _state.copyWith(
        isLoading: false,
        navigateTo: 'address',
        newAddress: entity,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        selectedDistrict: districtTmp,
        selectedProvince: provinceTmp,
        selectedWard: wardTmp,
      );
      notifyListeners();
      debugPrint('error edit address: $e');
    }
  }

  @override
  List<PlaceEntity> get districts => _state.districts;

  @override
  bool get isFormValid => _state.isFormValid;

  @override
  String? get navigateTo => _state.navigateTo;

  @override
  List<PlaceEntity> get provinces => _state.provinces;

  @override
  List<PlaceEntity> get wards => _state.wards;

  @override
  bool get isDefault => _state.isDefault;

  @override
  void setDefaultAddress({required bool isDefault}) {
    if (_state.isDefault != isDefault) {
      _state = _state.copyWith(
        isDefault: isDefault,
        selectedProvince: provinceTmp,
        selectedDistrict: districtTmp,
        selectedWard: wardTmp,
      );
      notifyListeners();
    }
  }

  @override
  AddressEntity? get newAddress => _state.newAddress;
}
