import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/entities/place/place_entity.dart';
import 'package:ecommerce/domain/usecases/create_address/create_address_params.dart';
import 'package:ecommerce/domain/usecases/create_address/fetch_create_address.dart';
import 'package:ecommerce/domain/usecases/place/fetch_districts.dart';
import 'package:ecommerce/domain/usecases/place/fetch_provinces.dart';
import 'package:ecommerce/domain/usecases/place/fetch_wards.dart';
import 'package:ecommerce/presentation/presenters/add_address/add_address_state.dart';
import 'package:ecommerce/presentation/screens/add_address/add_address_presenter.dart';
import 'package:flutter/material.dart';

class ProviderAddAddressPresenter
    with ChangeNotifier
    implements AddAddressPresenter {
  AddAddressState _state;

  final FetchProvinces _fetchProvinces;
  final FetchDistricts _fetchDistricts;
  final FetchWards _fetchWards;
  final FetchCreateAddress _fetchCreateAddress;

  ProviderAddAddressPresenter({
    required AddAddressState state,
    required FetchProvinces fetchProvinces,
    required FetchDistricts fetchDistricts,
    required FetchWards fetchWards,
    required FetchCreateAddress fetchCreateAddress,
  })  : _state = state,
        _fetchProvinces = fetchProvinces,
        _fetchDistricts = fetchDistricts,
        _fetchWards = fetchWards,
        _fetchCreateAddress = fetchCreateAddress;

  @override
  void navigateToAddAddress() {}

  @override
  bool get isFormValid => _state.isFormValid;

  @override
  bool get isLoading => _state.isLoading;

  @override
  void initData() async {
    try {
      List<PlaceEntity> provinces = await _fetchProvinces.call();
      _state = _state.copyWith(provinces: provinces);
      notifyListeners();
    } catch (e) {
      debugPrint('error init data add address: $e');
    }
  }

  @override
  List<PlaceEntity> get provinces => _state.provinces;

  @override
  List<PlaceEntity> get districts => _state.districts;

  @override
  PlaceEntity? get selectedDistrict => _state.selectedDistrict;

  @override
  PlaceEntity? get selectedProvince => _state.selectedProvince;

  @override
  PlaceEntity? get selectedWard => _state.selectedWard;

  @override
  List<PlaceEntity> get wards => _state.wards;

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
  void createAddress() async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      AddressEntity entity = await _fetchCreateAddress.call(
        params: CreateAddressParams(
          email: _state.email!,
          firstName: _state.firstName!,
          lastName: _state.lastName!,
          provinceCode: _state.selectedProvince!.code,
          provinceName: _state.selectedProvince!.name,
          districtCode: _state.selectedDistrict!.code,
          districtName: _state.selectedDistrict!.name,
          wardCode: _state.selectedWard!.code,
          wardName: _state.selectedWard!.name,
          detail: _state.detailAddress!,
          phone: _state.phone!,
        ),
      );

      _state = _state.copyWith(
        isLoading: false,
        navigateTo: 'address',
        newAddress: entity,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
      debugPrint('error create address: $e');
    }
  }

  @override
  String? get navigateTo => _state.navigateTo;

  @override
  AddressEntity? get newAddress => _state.newAddress;
}
