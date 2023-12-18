// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/usecases/edit_address/edit_address_params.dart';
import 'package:equatable/equatable.dart';

class RemoteEditAddressParams extends Equatable {
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
  final int id;

  const RemoteEditAddressParams({
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
    required this.id,
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
        id,
      ];

  factory RemoteEditAddressParams.fromDomain(EditAddressParams params) =>
      RemoteEditAddressParams(
        email: params.email,
        firstName: params.firstName,
        lastName: params.lastName,
        provinceCode: params.provinceCode,
        provinceName: params.provinceName,
        districtCode: params.districtCode,
        districtName: params.districtName,
        wardCode: params.wardCode,
        wardName: params.wardName,
        phone: params.phone,
        detail: params.detail,
        isAddressProfile: params.isAddressProfile,
        id: params.id,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'provinceCode': provinceCode,
        'provinceName': provinceName,
        'districtCode': districtCode,
        'districtName': districtName,
        'wardCode': wardCode.toString(),
        'wardName': wardName,
        'phone': phone,
        'detail': detail,
        'isAddressProfile': isAddressProfile,
        'id': id,
      };
}
