import 'package:ecommerce/domain/entities/address/address_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final int provinceCode;
  final String provinceName;
  final int districtCode;
  final String districtName;
  final String wardCode;
  final String wardName;
  final String detail;
  final String phone;
  final bool? isAddressProfile;
  final bool? isDefault;

  AddressModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.provinceCode,
    required this.provinceName,
    required this.districtCode,
    required this.districtName,
    required this.wardCode,
    required this.wardName,
    required this.detail,
    required this.phone,
    this.isAddressProfile,
    this.isDefault,
  });

  AddressModel copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    int? provinceCode,
    String? provinceName,
    int? districtCode,
    String? districtName,
    String? wardCode,
    String? wardName,
    String? detail,
    String? phone,
    bool? isAddressProfile,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      provinceCode: provinceCode ?? this.provinceCode,
      provinceName: provinceName ?? this.provinceName,
      districtCode: districtCode ?? this.districtCode,
      districtName: districtName ?? this.districtName,
      wardCode: wardCode ?? this.wardCode,
      wardName: wardName ?? this.wardName,
      detail: detail ?? this.detail,
      phone: phone ?? this.phone,
      isAddressProfile: isAddressProfile ?? this.isAddressProfile,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'provinceCode': provinceCode,
      'provinceName': provinceName,
      'districtCode': districtCode,
      'districtName': districtName,
      'wardCode': wardCode,
      'wardName': wardName,
      'detail': detail,
      'phone': phone,
      'isAddressProfile': isAddressProfile,
      'id': id,
      'isDefault': isDefault,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as int,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      provinceCode: map['provinceCode'] as int,
      provinceName: map['provinceName'] as String,
      districtCode: map['districtCode'] as int,
      districtName: map['districtName'] as String,
      wardCode: map['wardCode'] as String,
      wardName: map['wardName'] as String,
      detail: map['detail'] as String,
      phone: map['phone'] as String,
      isAddressProfile: map['isAddressProfile'] != null
          ? map['isAddressProfile'] as bool
          : null,
      isDefault: map['isDefault'],
    );
  }

  AddressEntity toEntity() => AddressEntity(
        id: id,
        email: email,
        firstName: firstName,
        lastName: lastName,
        provinceCode: provinceCode,
        provinceName: provinceName,
        districtCode: districtCode,
        districtName: districtName,
        wardCode: wardCode,
        wardName: wardName,
        detail: detail,
        phone: phone,
        isDefault: isDefault,
      );
}
