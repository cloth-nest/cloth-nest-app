// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/entities/place/place_entity.dart';

class DetailAddressState {
  final bool isLoading;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController mailController;
  final TextEditingController detailController;
  final PlaceEntity? selectedProvince;
  final PlaceEntity? selectedDistrict;
  final PlaceEntity? selectedWard;
  final AddressEntity? address;
  final List<PlaceEntity> districts;
  final List<PlaceEntity> wards;
  final List<PlaceEntity> provinces;
  final bool isFormValid;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? detailAddress;
  final String? navigateTo;
  final int? id;
  final bool isDefault;

  const DetailAddressState({
    required this.isLoading,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.mailController,
    required this.detailController,
    this.selectedDistrict,
    this.selectedProvince,
    this.selectedWard,
    this.address,
    required this.districts,
    required this.wards,
    required this.provinces,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.detailAddress,
    this.navigateTo,
    this.id,
    required this.isFormValid,
    required this.isDefault,
  });

  factory DetailAddressState.initial() {
    return DetailAddressState(
      isLoading: false,
      firstNameController: TextEditingController(),
      lastNameController: TextEditingController(),
      phoneController: TextEditingController(),
      mailController: TextEditingController(),
      detailController: TextEditingController(),
      districts: [],
      wards: [],
      provinces: [],
      isFormValid: false,
      id: null,
      isDefault: false,
    );
  }

  DetailAddressState copyWith({
    bool? isLoading,
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? phoneController,
    TextEditingController? mailController,
    TextEditingController? detailController,
    PlaceEntity? selectedProvince,
    PlaceEntity? selectedDistrict,
    PlaceEntity? selectedWard,
    AddressEntity? address,
    List<PlaceEntity>? districts,
    List<PlaceEntity>? wards,
    List<PlaceEntity>? provinces,
    bool? isFormValid,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? detailAddress,
    String? navigateTo,
    int? id,
    bool? isDefault,
  }) {
    return DetailAddressState(
      isLoading: isLoading ?? this.isLoading,
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      phoneController: phoneController ?? this.phoneController,
      mailController: mailController ?? this.mailController,
      detailController: detailController ?? this.detailController,
      selectedProvince: selectedProvince,
      selectedDistrict: selectedDistrict,
      selectedWard: selectedWard,
      address: address ?? this.address,
      districts: districts ?? this.districts,
      wards: wards ?? this.wards,
      provinces: provinces ?? this.provinces,
      isFormValid: isFormValid ?? this.isFormValid,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      detailAddress: detailAddress ?? this.detailAddress,
      navigateTo: navigateTo ?? this.navigateTo,
      id: id ?? this.id,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
