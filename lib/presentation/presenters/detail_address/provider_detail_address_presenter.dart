import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/entities/place/place_entity.dart';
import 'package:ecommerce/domain/usecases/detail_address/fetch_detail_address.dart';
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

  ProviderDetailAddressPresenter({
    required DetailAddressState state,
    required FetchDetailAddress fetchDetailAddress,
    required FetchDistricts fetchDistricts,
    required FetchWards fetchWards,
    required FetchProvinces fetchProvinces,
  })  : _state = state,
        _fetchDetailAddress = fetchDetailAddress,
        _fetchDistricts = fetchDistricts,
        _fetchProvinces = fetchProvinces,
        _fetchWards = fetchWards;

  @override
  bool get isLoading => _state.isLoading;

  @override
  void initData({required int idAddress}) async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      AddressEntity entity = await _fetchDetailAddress.call(id: idAddress);
      List<PlaceEntity> provinces = await _getProvinces();
      List<PlaceEntity> wards = await _getWards(entity.wardCode);
      List<PlaceEntity> districts = await _getDistricts(entity.districtCode);

      _state = _state.copyWith(
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
          _state.selectedProvince != null &&
          _state.selectedDistrict != null &&
          _state.selectedWard != null,
    );
  }

  @override
  void setDetailAddress({required String detail}) {
    if (_state.detailAddress != detail) {
      _state = _state.copyWith(
        detailAddress: detail,
      );
      _validateForm();

      notifyListeners();
    }
  }

  @override
  void editAddress() async {
    try {
      // _state = _state.copyWith(isLoading: true);
      // notifyListeners();

      // await _fetchCreateAddress.call(
      //   params: CreateAddressParams(
      //     email: _state.email!,
      //     firstName: _state.firstName!,
      //     lastName: _state.lastName!,
      //     provinceCode: _state.selectedProvince!.code,
      //     provinceName: _state.selectedProvince!.name,
      //     districtCode: _state.selectedDistrict!.code,
      //     districtName: _state.selectedDistrict!.name,
      //     wardCode: _state.selectedWard!.code,
      //     wardName: _state.selectedWard!.name,
      //     detail: _state.detailAddress!,
      //     phone: _state.phone!,
      //   ),
      // );

      // _state = _state.copyWith(isLoading: false, navigateTo: 'address');
      // notifyListeners();
    } catch (e) {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
      debugPrint('error create address: $e');
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
}
