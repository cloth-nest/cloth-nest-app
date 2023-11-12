// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CreateAddressParams extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final int provinceCode;
  final String provinceName;
  final int districtCode;
  final String districtName;
  final int wardCode;
  final String wardName;
  final String detail;
  final String phone;
  final bool? isAddressProfile;

  const CreateAddressParams({
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
    this.isAddressProfile = false,
  });

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        provinceCode,
        provinceName,
        districtCode,
        districtName,
        wardCode,
        wardName,
        phone,
        detail,
      ];
}
