// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/place/place_entity.dart';

class AddAddressState {
  final bool isLoading;
  final bool isFormValid;
  final List<PlaceEntity> provinces;
  final List<PlaceEntity> wards;
  final List<PlaceEntity> districts;
  final PlaceEntity? selectedProvince;
  final PlaceEntity? selectedDistrict;
  final PlaceEntity? selectedWard;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? detailAddress;
  final String? navigateTo;

  const AddAddressState({
    required this.isFormValid,
    required this.isLoading,
    required this.provinces,
    required this.wards,
    required this.districts,
    this.selectedProvince,
    this.selectedDistrict,
    this.selectedWard,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.detailAddress,
    this.navigateTo,
  });

  factory AddAddressState.initial() {
    return const AddAddressState(
      isFormValid: false,
      isLoading: false,
      provinces: [],
      wards: [],
      districts: [],
    );
  }

  AddAddressState copyWith({
    bool? isLoading,
    bool? isFormValid,
    List<PlaceEntity>? provinces,
    List<PlaceEntity>? wards,
    List<PlaceEntity>? districts,
    PlaceEntity? selectedProvince,
    PlaceEntity? selectedDistrict,
    PlaceEntity? selectedWard,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? detailAddress,
    String? navigateTo,
  }) {
    return AddAddressState(
      isLoading: isLoading ?? this.isLoading,
      isFormValid: isFormValid ?? this.isFormValid,
      provinces: provinces ?? this.provinces,
      wards: wards ?? this.wards,
      districts: districts ?? this.districts,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedWard: selectedWard ?? this.selectedWard,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      detailAddress: detailAddress ?? this.detailAddress,
      navigateTo: navigateTo ?? this.navigateTo,
    );
  }
}
