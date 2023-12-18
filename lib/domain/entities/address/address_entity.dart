// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressEntity {
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
  final int id;
  final bool? isDefault;

  AddressEntity({
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
    required this.id,
  });

  AddressEntity copyWith({
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
    int? id,
    bool? isDefault,
  }) {
    return AddressEntity(
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
      id: id ?? this.id,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
